import 'package:app/app_theme/theme_context_extensions.dart';
import 'package:app/base/common_widgets/image_widgets/app_image_view.dart';
import 'package:app/base/utils/colors.dart';
import 'package:app/base/utils/iterable.dart';
import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

enum SelectableViewSelectionMode {
  single,
  multi,
}

enum SelectableViewType {
  verticalListView,
  horizontalListView,
  wrapGridView;

  Axis get axis {
    switch (this) {
      case SelectableViewType.verticalListView:
        return Axis.vertical;
      case SelectableViewType.horizontalListView:
        return Axis.horizontal;
      case SelectableViewType.wrapGridView:
        return Axis.horizontal;
    }
  }
}

abstract class ListItem {
  String get listTitle;
  bool get isSelected;
  String? get imageUrl;
}

class ListItemString implements ListItem {
  ListItemString(this._value);
  final String _value;

  @override
  String get listTitle => _value;

  @override
  bool get isSelected => false;

  @override
  String? get imageUrl => throw UnimplementedError();
}

class SelectableView<T extends ListItem> extends StatefulWidget {
  const SelectableView(
      {required this.items,
      super.key,
      this.onSelectionChanged,
      this.itemBuilder,
      this.selectionMode = SelectableViewSelectionMode.single,
      this.viewType = SelectableViewType.verticalListView,
      this.shrinkWrap = false});
  final List<T> items;
  final Function(List<T>)? onSelectionChanged;
  final Widget Function(BuildContext, T, bool)? itemBuilder;
  final SelectableViewSelectionMode selectionMode;
  final SelectableViewType viewType;
  final bool shrinkWrap;

  @override
  _SelectableViewState<T> createState() => _SelectableViewState<T>();
}

class _SelectableViewState<T extends ListItem>
    extends State<SelectableView<T>> {
  late List<bool> _selected;
  List<T> _items = [];

  @override
  void initState() {
    _items = widget.items;
    _selected = [];
    for (final item in _items) {
      _selected.add(item.isSelected);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.viewType) {
      case SelectableViewType.wrapGridView:
        return Wrap(
          runSpacing: 15,
          spacing: 2,
          children: widget.items.enumerate().map((item) {
            if (widget.itemBuilder != null) {
              return InkWell(
                onTap: () {
                  _handleSelection(item.key);
                },
                child: widget.itemBuilder!(
                    context, item.value, _selected[item.key]),
              );
            } else {
              return _defaultItemBuilder(
                  context, item.value, item.key, _selected[item.key]);
            }
          }).toList(),
        );
      default:
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.items.length,
          shrinkWrap: widget.shrinkWrap,
          scrollDirection: widget.viewType.axis,
          itemBuilder: (context, index) {
            final item = widget.items[index];
            if (widget.itemBuilder != null) {
              return InkWell(
                key: GlobalObjectKey(item.hashCode),
                onTap: () {
                  Scrollable.ensureVisible(
                      GlobalObjectKey(item.hashCode).currentContext!,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                  _handleSelection(index);
                },
                child: widget.itemBuilder!(context, item, _selected[index]),
              );
            } else {
              return _defaultItemBuilder(
                  context, item, index, _selected[index]);
            }
          },
        );
    }
  }

  Widget _defaultItemBuilder(
      BuildContext context, T item, int index, bool isSelected) {
    switch (widget.viewType) {
      case SelectableViewType.verticalListView:
        return _verticalScrollableDefaultItem(context, item, index, isSelected);
      default:
        return _horizontalScrollableDefaultItem(
            context, item, index, isSelected);
    }
  }

  Widget _verticalScrollableDefaultItem(
      BuildContext context, T item, int index, bool isSelected) {
    return ListTile(
      leading: AppImageView(
        avatarUrl: item.imageUrl,
        width: 40,
        height: 40,
        cornerRadius: 20,
      ), // You can replace this with your image
      title: Text(
        item.listTitle,
        style:
            AppStyles.boldSmall(color: context.colorScheme.onPrimary),
      ), // Use the provided title
      trailing: Checkbox(
        value: _selected[index],
        activeColor: context.colorScheme.primary,
        checkColor: context.colorScheme.onPrimary,
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return context.colorScheme.primary;
          }
          return context.colorScheme.onPrimary;
        }),
        onChanged: (widget.selectionMode == SelectableViewSelectionMode.single)
            ? null
            : (value) {
                _handleSelection(index);
              },
      ),
      onTap: () {
        _handleSelection(index);
      },
    );
  }

  Widget _horizontalScrollableDefaultItem(
      BuildContext context, T item, int index, bool isSelected) {
    return GestureDetector(
      onTap: () {
        _handleSelection(index);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? context.theme.primaryColor
                  : AppColors.transparent,
              border: Border.all(
                  color: context.theme.primaryColor, width: 1.5)),
          child: Text(
            item.listTitle,
            style: isSelected
                ? TextStyle(
                    color: context.colorScheme.onPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)
                : TextStyle(
                    color: context.theme.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
          )),
    );
  }

  void _handleSelection(int index) {
    setState(() {
      if (widget.selectionMode == SelectableViewSelectionMode.single) {
        _selected = List<bool>.filled(widget.items.length, false);
      }
      _selected[index] = !_selected[index];
      if (widget.onSelectionChanged != null) {
        final selectedItems = _getSelectedItems();
        widget.onSelectionChanged!(selectedItems);
      }
    });
  }

  List<T> _getSelectedItems() {
    final selectedItems = <T>[];
    for (var i = 0; i < _selected.length; i++) {
      if (_selected[i]) {
        selectedItems.add(widget.items[i]);
      }
    }
    return selectedItems;
  }
}
