import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injector/injector.dart';
import 'app_version_info_view_type.dart';
import 'bloc/app_version_info_view_bloc.dart';
import 'sub_view/app_update_view.dart';

class AppVersionInfoView extends StatefulWidget {
  final AppVersionInfoViewType viewType;
  const AppVersionInfoView({required this.viewType, super.key});

  @override
  State<AppVersionInfoView> createState() => _AppVersionInfoViewState();
}

class _AppVersionInfoViewState extends State<AppVersionInfoView> {
  late final AppVersionInfoViewBloc _bloc;
  @override
  void initState() {
    _bloc = Injector.instance<AppVersionInfoViewBloc>();
    _bloc.add(FetchAppInformationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: BlocConsumer<AppVersionInfoViewBloc, AppVersionInfoViewState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchedAppInformationState) {
            return AppUpdateView(
                viewType: widget.viewType,
                appInformation: state.appInformation);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
