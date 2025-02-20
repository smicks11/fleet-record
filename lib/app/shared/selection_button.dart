import 'package:fleet_app/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectionButtonData {
  final String activeIcon;
  final String icon;
  final String label;
  final int? totalNotif;

  SelectionButtonData({
    required this.activeIcon,
    required this.icon,
    required this.label,
    this.totalNotif,
  });
}

class SelectionButton extends StatefulWidget {
  const SelectionButton({
    this.initialSelected = 0,
    required this.data,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  final int initialSelected;
  final List<SelectionButtonData> data;
  final Function(int index, SelectionButtonData value) onSelected;

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.data.asMap().entries.map((e) {
        final index = e.key;
        final data = e.value;

        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: _Button(
            selected: selected == index,
            onPressed: () {
              widget.onSelected(index, data);
              setState(() {
                selected = index;
              });
            },
            data: data,
          ),
        );
      }).toList(),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.selected,
    required this.data,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final bool selected;
  final SelectionButtonData data;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 7, bottom: 10),
      child: Material(
        color:
            (!selected) ? Colors.transparent : Colors.grey.withOpacity(0.1),
        borderRadius:  BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            topRight: Radius.zero,
            bottomRight: Radius.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                _buildIcon(context),
                const SizedBox(width: 20 / 2),
                Expanded(child: _buildLabel(context, selected)),
                if (data.totalNotif != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 20 / 2),
                    child: _buildNotif(),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildIcon(BuildContext context) {
  //   return Icon(
  //     (!selected) ? data.icon : data.activeIcon,
  //     size: 14,
  //     color: (!selected)
  //         ? AppColors.kFontColorPallets[1]
  //         : Theme.of(context).primaryColor,
  //   );
  // }

  

Widget _buildIcon(BuildContext context) {
  return SvgPicture.asset(
    selected ? data.activeIcon : data.icon, 
    width: 14,
    height: 14,
    // color: selected 
    //     ? Theme.of(context).primaryColor 
    //     :  Theme.of(context).primaryColor // Apply color
  );
}


  Widget _buildLabel(BuildContext context, final bool selected) {
    return Text(
      data.label,
      style: TextStyle(
        color: Color(0xff252C32),
        // color: (!selected)
        //     ? const Color(0xff949494)
        //     : Theme.of(context).primaryColor,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        letterSpacing: .8,
        fontSize: 12,
      ),
    );
  }

  Widget _buildNotif() {
    return (data.totalNotif == null || data.totalNotif! <= 0)
        ? Container()
        : Container(
            width: 30,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              (data.totalNotif! >= 100) ? "30+" : "${data.totalNotif}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          );
  }
}
