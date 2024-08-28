import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:watso_v2/common/utils/utils.dart';

import '../../common/constants/styles.dart';
import '../../common/router/routes.dart';
import '../../common/widgets/Boxes.dart';
import '../model/taxi_model.dart';
import '../provider/main_provider.dart';

class MainBody extends ConsumerWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<TaxiGroup>> groups = ref.watch(filteredGroupsProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text("택시리스트", style: WatsoFont.title),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(" 출발 시간 ∙ 도착지  ∙ 요금 ∙  정원",
              style: TextStyle(color: Colors.grey[600], fontSize: 11)),
        ),
        groups.when(data: (data) {
          if (data.isEmpty)
            return AngularBox(
                margin: EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Text("모집중인 택시가 없습니다"));
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (TaxiGroup group in data) ...{
                InkWell(
                    onTap: () {
                      context.push(Routes.tRecruit(group.id.toString()).path);
                    },
                    child: AngularBox(
                      margin: EdgeInsets.only(bottom: 16.0),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(convertTimeAMPM(group.departDatetime),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 24),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset("assets/icons/pin.svg"),
                                    SizedBox(width: 4),
                                    Text(
                                      group.direction.toKorean() + '행',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "참여 시 예상 금액 :  ",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text('${group.fee.cost}원')
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset("assets/icons/group.svg"),
                                    SizedBox(width: 4),
                                    Text("1/4명"),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              }
            ],
          );
        }, error: (err, stack) {
          print(err);
          print(stack);
          return AngularBox(
              margin: EdgeInsets.only(bottom: 16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Text("에러가 발생했습니다" + err.toString()));
        }, loading: () {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          );
        }),
      ],
    );
  }
}
