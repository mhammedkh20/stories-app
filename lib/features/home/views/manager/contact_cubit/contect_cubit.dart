import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stories_app/features/home/data/contect_repo_imp.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContectState> {
  final _contactRepoImp = ContactRepoImp();

  bool loading = true;

  String htmlPage = '';

  ContactCubit() : super(ContectInitial());

  static ContactCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  getHTMLPage() async {
    htmlPage = await _contactRepoImp.getContactPage();
    loading = false;
    emit(LoadedPage());
  }
}
