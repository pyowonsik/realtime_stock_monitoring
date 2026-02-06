import 'package:flutter/material.dart';
import 'package:realtime_stock_monitoring/core/utils/price_formatter.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/widget/comparison_item_widget.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/widget/info_row_widget.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/widget/shareholder_bar_widget.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/widget/table_widgets.dart';

/// 요약 섹션 위젯
class SummarySectionWidget extends StatelessWidget {
  const SummarySectionWidget({
    required this.stockCode,
    required this.stockName,
    required this.currentPrice,
    required this.changeRate,
    super.key,
  });

  final String stockCode;
  final String stockName;
  final int currentPrice;
  final double changeRate;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '종목 요약',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            InfoRowWidget(label: '종목코드', value: stockCode),
            InfoRowWidget(label: '종목명', value: stockName),
            InfoRowWidget(
              label: '현재가',
              value: PriceFormatter.formatPrice(currentPrice),
            ),
            InfoRowWidget(
              label: '등락률',
              value: PriceFormatter.formatChangeRate(changeRate),
              valueColor: changeRate >= 0 ? Colors.red : Colors.blue,
            ),
            const Divider(height: 24),
            const InfoRowWidget(label: '시가총액', value: '430조 5,000억'),
            const InfoRowWidget(label: '거래량', value: '12,345,678주'),
            const InfoRowWidget(label: '52주 최고', value: '88,000원'),
            const InfoRowWidget(label: '52주 최저', value: '59,000원'),
            const InfoRowWidget(label: 'PER', value: '15.32'),
            const InfoRowWidget(label: 'PBR', value: '1.45'),
          ],
        ),
      ),
    );
  }
}

/// 뉴스 섹션 위젯
class NewsSectionWidget extends StatelessWidget {
  const NewsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mockNews = [
      {
        'title': '삼성전자, AI 반도체 수주 확대...HBM3E 양산 본격화',
        'source': '한국경제',
        'time': '2시간 전',
      },
      {
        'title': '글로벌 메모리 시장 회복세...삼성전자 수혜 전망',
        'source': '매일경제',
        'time': '4시간 전',
      },
      {
        'title': '삼성전자 파운드리, 2나노 공정 개발 완료',
        'source': '조선비즈',
        'time': '6시간 전',
      },
      {
        'title': '갤럭시 S25 시리즈 사전예약 역대 최다 기록',
        'source': 'IT조선',
        'time': '8시간 전',
      },
      {
        'title': '외국인 투자자, 삼성전자 연속 순매수',
        'source': '연합뉴스',
        'time': '10시간 전',
      },
    ];

    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '관련 뉴스',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mockNews.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final news = mockNews[index];
              return ListTile(
                title: Text(
                  news['title']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${news['source']} • ${news['time']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}

/// 재무 섹션 위젯
class FinanceSectionWidget extends StatelessWidget {
  const FinanceSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '재무 정보',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // 연도별 매출/영업이익
            Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  ),
                  children: const [
                    TableHeaderWidget(text: '구분'),
                    TableHeaderWidget(text: '2022'),
                    TableHeaderWidget(text: '2023'),
                    TableHeaderWidget(text: '2024E'),
                  ],
                ),
                const TableRow(
                  children: [
                    TableCellWidget(text: '매출액'),
                    TableCellWidget(text: '302조'),
                    TableCellWidget(text: '258조'),
                    TableCellWidget(text: '310조'),
                  ],
                ),
                const TableRow(
                  children: [
                    TableCellWidget(text: '영업이익'),
                    TableCellWidget(text: '43조'),
                    TableCellWidget(text: '6.5조'),
                    TableCellWidget(text: '35조'),
                  ],
                ),
                const TableRow(
                  children: [
                    TableCellWidget(text: '순이익'),
                    TableCellWidget(text: '55조'),
                    TableCellWidget(text: '15조'),
                    TableCellWidget(text: '28조'),
                  ],
                ),
                const TableRow(
                  children: [
                    TableCellWidget(text: 'ROE'),
                    TableCellWidget(text: '16.2%'),
                    TableCellWidget(text: '4.5%'),
                    TableCellWidget(text: '8.5%'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '2024년 AI 반도체 수요 증가로 실적 개선 전망',
                      style: TextStyle(
                        color: Colors.amber.shade900,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 기타 섹션 위젯
class OtherSectionWidget extends StatelessWidget {
  const OtherSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '기타 정보',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // 주주 구성
            const Text(
              '주주 구성',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const ShareholderBarWidget(
              shareholders: [
                ShareholderData('외국인', 52.3, Colors.blue),
                ShareholderData('기관', 18.5, Colors.green),
                ShareholderData('개인', 29.2, Colors.orange),
              ],
            ),
            const SizedBox(height: 24),
            // 동종 업계 비교
            const Text(
              '동종 업계 비교',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const ComparisonItemWidget(
                company: 'SK하이닉스', price: '185,000원', change: '+2.5%'),
            const ComparisonItemWidget(
                company: 'TSMC', price: r'$180.50', change: '+1.2%'),
            const ComparisonItemWidget(
                company: 'Intel', price: r'$45.30', change: '-0.8%'),
            const SizedBox(height: 16),
            // 공시 정보
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '최근 공시',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• [정정] 분기보고서 (2024.03)\n'
                    '• 주요사항보고서 (자기주식처분결정)\n'
                    '• 기업설명회(IR) 개최',
                    style: TextStyle(fontSize: 12, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
