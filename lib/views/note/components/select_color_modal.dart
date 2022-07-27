import 'package:flutter/material.dart';

class SelectColorModal extends StatelessWidget {
  const SelectColorModal(
      {Key? key, required this.changeColor, required this.color})
      : super(key: key);
  final ValueChanged<int> changeColor;
  final ValueNotifier<int> color;
  @override
  Widget build(BuildContext context) {
    final colorDefault = Theme.of(context).backgroundColor.value;
    List<int> colors = [
      colorDefault,
      0xffa4b0be,
      0xffF1A2E0,
      0xffA2ACF1,
      0xffCCF1A2,
      0xffA2B3F1,
      0xffBD9393,
      0xffBAB0E8
    ];
    return Container(
      height: 60,
      margin: const EdgeInsets.only(
        left: 6,
      ),
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: const Icon(Icons.palette),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => ValueListenableBuilder(
                    valueListenable: color,
                    builder: ((context, value, child) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          color: Color(color.value),
                          child: SafeArea(
                            child: Wrap(
                              children: [
                                const SizedBox(
                                  width: double.infinity,
                                  height: 10,
                                ),
                                const ListTile(
                                  title: Text("Chọn màu nền"),
                                ),
                                const SizedBox(
                                  width: double.infinity,
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: ListView.builder(
                                      itemCount: colors.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: ((context, index) => Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: GestureDetector(
                                                child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Color(colors[index]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      border: Border.all(
                                                          color: colors[
                                                                      index] ==
                                                                  color.value
                                                              ? const Color(
                                                                  0xff82ccdd)
                                                              : Colors.black26,
                                                          width: 1.5),
                                                    ),
                                                    child: colors[index] ==
                                                            color.value
                                                        ? Icon(Icons.done,
                                                            color: Theme.of(
                                                                    context)
                                                                .iconTheme
                                                                .color)
                                                        : null),
                                                onTap: () {
                                                  changeColor(colors[index]);
                                                  color.value = colors[index];
                                                }),
                                          ))),
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ));
        },
      ),
    );
  }
}
