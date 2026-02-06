import 'package:flutter/material.dart';

/// 확장 패널 섹션 위젯
class ExpansionSectionWidget extends StatefulWidget {
  const ExpansionSectionWidget({super.key});

  @override
  State<ExpansionSectionWidget> createState() => _ExpansionSectionWidgetState();
}

class _ExpansionSectionWidgetState extends State<ExpansionSectionWidget> {
  final List<_PanelItem> _panels = [
    _PanelItem(
      title: '기업 개요',
      content: '삼성전자는 대한민국의 다국적 전자기업입니다. '
          '반도체, 디스플레이, 스마트폰 등 다양한 전자제품을 생산합니다. '
          '1969년 설립되어 현재 전 세계 최대의 메모리 반도체 제조업체입니다.',
    ),
    _PanelItem(
      title: '투자 포인트',
      content: '• AI 반도체 수요 증가에 따른 HBM 매출 성장 기대\n'
          '• 파운드리 사업 확대로 비메모리 매출 다각화\n'
          '• 갤럭시 시리즈 스마트폰 판매 호조\n'
          '• 주주환원 정책 강화',
    ),
    _PanelItem(
      title: '리스크 요인',
      content: '• 글로벌 경기 침체 시 IT 수요 감소 우려\n'
          '• 미중 무역 갈등에 따른 반도체 공급망 리스크\n'
          '• 경쟁사와의 기술 격차 축소\n'
          '• 원/달러 환율 변동 리스크',
    ),
    _PanelItem(
      title: '배당 정보',
      content: '• 배당 수익률: 약 2.5%\n'
          '• 연간 배당금: 주당 1,444원\n'
          '• 배당 성향: 약 25%\n'
          '• 분기 배당 실시',
    ),
    _PanelItem(
      title: '애널리스트 의견',
      content: '• 목표주가 평균: 85,000원\n'
          '• 매수 의견: 75%\n'
          '• 중립 의견: 20%\n'
          '• 매도 의견: 5%',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '상세 정보',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ExpansionPanelList(
            elevation: 0,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _panels[panelIndex].isExpanded = isExpanded;
              });
            },
            children: _panels.map((panel) {
              return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      panel.title,
                      style: TextStyle(
                        fontWeight:
                            isExpanded ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    leading: Icon(
                      isExpanded
                          ? Icons.remove_circle_outline
                          : Icons.add_circle_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                },
                body: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    panel.content,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ),
                isExpanded: panel.isExpanded,
                canTapOnHeader: true,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PanelItem {
  _PanelItem({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;
  bool isExpanded = false;
}
