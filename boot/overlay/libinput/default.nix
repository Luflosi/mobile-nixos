{ libinput }:

libinput.override {
  wacomSupport = false;
  luaSupport = false;
  documentationSupport = false;
  eventGUISupport = false;
  testsSupport = false;
  valgrind = null;
}
