// ignore_for_file: unused_import
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'combase.dart';
import 'comerrors.dart';

import '../constants.dart';
import '../macros.dart';
import '../structs.dart';
import '../win32.dart';

const IID_IUnknown = '{00000000-0000-0000-C000-000000000046}';

typedef QueryInterface_Native = Int32 Function(
    Pointer obj, Pointer<GUID> riid, Pointer<IntPtr> ppvObject);
typedef QueryInterface_Dart = int Function(
    Pointer obj, Pointer<GUID> riid, Pointer<IntPtr> ppvObject);

typedef AddRef_Native = Int32 Function(Pointer obj);
typedef AddRef_Dart = int Function(Pointer obj);

typedef Release_Native = Int32 Function(Pointer obj);
typedef Release_Dart = int Function(Pointer obj);

class IUnknown {
  // vtable begins at 0, ends at 2

  Pointer<COMObject> ptr;

  IUnknown(this.ptr);

  int QueryInterface(Pointer<GUID> riid, Pointer<IntPtr> ppvObject) =>
      Pointer<NativeFunction<QueryInterface_Native>>.fromAddress(
              ptr.ref.vtable.elementAt(0).value)
          .asFunction<QueryInterface_Dart>()(ptr.ref.lpVtbl, riid, ppvObject);

  int AddRef() => Pointer<NativeFunction<AddRef_Native>>.fromAddress(
          ptr.ref.vtable.elementAt(1).value)
      .asFunction<AddRef_Dart>()(ptr.ref.lpVtbl);

  int Release() => Pointer<NativeFunction<Release_Native>>.fromAddress(
          ptr.ref.vtable.elementAt(2).value)
      .asFunction<Release_Dart>()(ptr.ref.lpVtbl);
}