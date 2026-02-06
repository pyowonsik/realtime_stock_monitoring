# Realtime Item - 실시간 관심 종목 모니터링 앱

실시간 가격 업데이트와 목표가 알림 기능을 제공하는 Flutter 관심 종목 모니터링 앱입니다.

## 실행 방법

### 요구사항
- Flutter SDK 3.10.0 이상
- Dart SDK 3.0.0 이상

### 설치 및 실행

```bash
# 1. 의존성 설치
flutter pub get

# 2. Freezed 코드 생성
flutter pub run build_runner build --delete-conflicting-outputs

# 3. 앱 실행
flutter run
```

### 빌드

```bash
# Android APK 빌드
flutter build apk --release

# iOS 빌드
flutter build ios --release
```

---

## 아키텍처 설명

### Clean Architecture + Feature-based Modularization

```
lib/
├── main.dart                    # 앱 진입점
├── core/                        # 공통 핵심 모듈
│   ├── constants/               # 상수 정의
│   ├── di/                      # 의존성 주입 (GetIt)
│   ├── services/                # 앱 서비스 (Notification, Lifecycle)
│   └── utils/                   # 유틸리티 함수
├── feature/                     # 기능별 모듈
│   ├── stock/                   # 전체 종목 기능
│   ├── favorite/                # 관심 종목 기능
│   └── alert/                   # 알림 기능
└── shared/                      # 공유 모듈
    ├── domain/                  # 공유 엔티티
    └── presentation/            # 공유 위젯
```

### 각 Feature 모듈 구조 (3-Layer Architecture)

```
feature/{feature_name}/
├── domain/                      # 도메인 레이어 (비즈니스 로직)
│   ├── entity/                  # Freezed 엔티티 (불변 객체)
│   ├── repository/              # 추상 레포지토리 인터페이스
│   └── usecase/                 # 유스케이스 (단일 책임)
├── data/                        # 데이터 레이어 (데이터 접근)
│   ├── model/                   # Hive 모델 (영속화)
│   ├── datasource/              # 데이터소스 (Local/Remote)
│   └── repository/              # 레포지토리 구현체
├── presentation/                # 프레젠테이션 레이어 (UI)
│   ├── provider/                # ChangeNotifier + Freezed State
│   ├── page/                    # 페이지 위젯
│   └── widget/                  # 재사용 위젯
└── di/                          # Feature 의존성 주입
```

### 핵심 기술 스택

| 기술 | 용도 |
|------|------|
| **Provider** | 상태 관리 (ChangeNotifier) |
| **Freezed** | 불변 엔티티, Union Type State |
| **GetIt** | 의존성 주입 |
| **Hive** | 로컬 데이터 영속화 |
| **RxDart** | 실시간 가격 스트림 (BehaviorSubject) |

### 데이터 흐름

```
[UI] → [Provider] → [UseCase] → [Repository] → [DataSource]
                                      ↓
                               [Local/Remote]
```

### 상태 관리 (Freezed Union Type)

```dart
@freezed
sealed class FavoriteState with _$FavoriteState {
  const factory FavoriteState.initial() = FavoriteInitial;
  const factory FavoriteState.loading() = FavoriteLoading;
  const factory FavoriteState.loaded({...}) = FavoriteLoaded;
  const factory FavoriteState.error({...}) = FavoriteError;
}

// UI에서 Switch 패턴 매칭으로 처리
return switch (provider.state) {
  FavoriteInitial() => LoadingWidget(),
  FavoriteLoading() => LoadingWidget(),
  FavoriteLoaded(favoriteList: final list) => ListView(...),
  FavoriteError(message: final msg) => ErrorWidget(msg),
};
```

---

## 종목 상세 페이지 - 섹션 네비게이션/하이라이팅 구현

### 개요

종목 상세 페이지(`FavoriteDetailPage`)는 7개의 섹션으로 구성되어 있으며, 스크롤 위치에 따라 네비게이션 버튼이 자동으로 하이라이팅됩니다.

### 화면 구조

```
┌─────────────────────────────────┐
│  SliverAppBar (종목명, 로고)     │ ← Pinned
├─────────────────────────────────┤
│  섹션 네비게이션 버튼 (가로 스크롤) │ ← Pinned (SliverPersistentHeader)
├─────────────────────────────────┤
│  [섹션 0: 가격] - 차트, 현재가    │
│  [섹션 1: 요약] - 기본 정보       │
│  [섹션 2: 입력] - 목표가 설정     │
│  [섹션 3: 확장 패널]             │
│  [섹션 4: 뉴스]                  │
│  [섹션 5: 재무]                  │
│  [섹션 6: 기타]                  │
└─────────────────────────────────┘
```

### 구현 방식

#### 1. GlobalKey를 사용한 섹션 위치 추적

각 섹션에 `GlobalKey`를 할당하여 위치를 추적합니다.

```dart
// 섹션 이름 목록
const List<String> _sectionNames = ['가격', '요약', '입력', '확장 패널', '뉴스', '재무', '기타'];

// 각 섹션의 GlobalKey 생성
final List<GlobalKey> _sectionKeys = List.generate(
  _sectionNames.length,
  (_) => GlobalKey(),
);

// 섹션에 Key 할당
SliverToBoxAdapter(
  child: Container(
    key: _sectionKeys[0],  // 가격 섹션
    child: PriceChartWidget(...),
  ),
),
```

#### 2. ScrollController를 사용한 스크롤 감지

스크롤 이벤트를 감지하여 현재 보이는 섹션을 결정합니다.

```dart
late ScrollController _scrollController;

@override
void initState() {
  super.initState();
  _scrollController = ScrollController()..addListener(_onScroll);
}

void _onScroll() {
  if (_isProgrammaticScroll) return;  // 프로그래매틱 스크롤 중에는 무시

  int newIndex = 0;

  for (int i = 0; i < _sectionKeys.length; i++) {
    final key = _sectionKeys[i];
    final context = key.currentContext;

    if (context != null) {
      final RenderBox box = context.findRenderObject()! as RenderBox;
      final position = box.localToGlobal(Offset.zero);

      // AppBar + Navigation 높이를 고려한 offset
      const headerOffset = 160.0;

      // 섹션이 화면 상단 근처에 있으면 해당 섹션 선택
      if (position.dy <= headerOffset + 50) {
        newIndex = i;
      }
    }
  }

  if (_selectedSectionIndex.value != newIndex) {
    _selectedSectionIndex.value = newIndex;
    _scrollNavToCenter(newIndex);  // 네비게이션 버튼도 스크롤
  }
}
```

#### 3. ValueNotifier를 사용한 효율적인 리빌드

`ValueNotifier`를 사용하여 섹션 인덱스 변경 시에만 네비게이션 버튼을 리빌드합니다.

```dart
// 현재 선택된 섹션 인덱스
final ValueNotifier<int> _selectedSectionIndex = ValueNotifier(0);

// UI에서 ValueListenableBuilder로 감지
SliverPersistentHeader(
  pinned: true,
  delegate: _SectionNavigationDelegate(
    child: ValueListenableBuilder<int>(
      valueListenable: _selectedSectionIndex,
      builder: (context, selectedIndex, _) {
        return SectionNavigationWidget(
          sectionNames: _sectionNames,
          selectedIndex: selectedIndex,
          onSectionTap: _scrollToSection,
          scrollController: _navScrollController,
        );
      },
    ),
  ),
),
```

#### 4. 버튼 클릭 시 해당 섹션으로 스크롤

`Scrollable.ensureVisible()`을 사용하여 부드럽게 스크롤합니다.

```dart
Future<void> _scrollToSection(int index) async {
  final key = _sectionKeys[index];
  final ctx = key.currentContext;

  if (ctx == null) return;

  _isProgrammaticScroll = true;  // 스크롤 이벤트 충돌 방지
  _selectedSectionIndex.value = index;

  await Scrollable.ensureVisible(
    ctx,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  await Future<void>.delayed(const Duration(milliseconds: 100));
  _isProgrammaticScroll = false;
}
```

#### 5. 네비게이션 버튼 자동 중앙 정렬

선택된 버튼이 화면 중앙에 오도록 네비게이션 바를 스크롤합니다.

```dart
void _scrollNavToCenter(int index) {
  if (!_navScrollController.hasClients) return;

  const buttonWidth = 80.0;
  final screenWidth = MediaQuery.of(context).size.width;
  final targetOffset = (index * buttonWidth) - (screenWidth / 2) + (buttonWidth / 2);

  _navScrollController.animateTo(
    targetOffset.clamp(0, _navScrollController.position.maxScrollExtent),
    duration: const Duration(milliseconds: 200),
    curve: Curves.easeInOut,
  );
}
```

### 핵심 포인트

| 기술 | 목적 |
|------|------|
| `GlobalKey` | 각 섹션의 위치 추적 |
| `ScrollController` | 스크롤 이벤트 감지 |
| `ValueNotifier` | 불필요한 리빌드 방지 |
| `Scrollable.ensureVisible()` | 부드러운 스크롤 애니메이션 |
| `_isProgrammaticScroll` 플래그 | 스크롤 이벤트 충돌 방지 |
| `SliverPersistentHeader` | 네비게이션 바 고정 (Pinned) |

---
