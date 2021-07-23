#include <souffle/SouffleInterface.h>

extern "C" souffle::SouffleProgram* souffle_init(char* file);
extern "C" void souffle_free(souffle::SouffleProgram* suf);
extern "C" void souffle_load_all(souffle::SouffleProgram* suf, char* dir);
extern "C" void souffle_run(souffle::SouffleProgram* suf);
extern "C" void souffle_print_all(souffle::SouffleProgram* suf, char* dir);
