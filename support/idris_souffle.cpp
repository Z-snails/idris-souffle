#include "idris_souffle.h"


extern "C" souffle::SouffleProgram* souffle_init(char* file) {
    return souffle::ProgramFactory::newInstance(file);
}

extern "C" void souffle_free(souffle::SouffleProgram* suf) {
    delete suf;
}

extern "C" void souffle_load_all(souffle::SouffleProgram* suf, char* dir) {
    suf->loadAll(dir);
}

extern "C" void souffle_run(souffle::SouffleProgram* suf) {
    suf->run();
}

extern "C" void souffle_print_all(souffle::SouffleProgram* suf, char* dir) {
    suf->printAll(dir);
}

