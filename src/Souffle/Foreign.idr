module Souffle.Foreign

export
data Souffle : Type where [external]

export
data Relation : Type where [external]

export
data ByteBuf : Type where [external]

private %foreign "C:souffle_init"
prim__init : String -> PrimIO (Ptr Souffle)

private %foreign "C:souffle_free"
prim__free : Ptr Souffle -> PrimIO ()

private %foreign "C:souffle_load_all"
prim__load_all : Ptr Souffle -> String -> PrimIO ()

private %foreign "C:souffle_run"
prim__run : Ptr Souffle -> PrimIO ()

private %foreign "C:souffle_print_all"
prim__print_all : Ptr Souffle -> String -> PrimIO ()

unsafePerformPrimIO : PrimIO a -> a
unsafePerformPrimIO act = unsafePerformIO $ fromPrim act

export
withSouffle : String -> (1 f : (1 _ : Ptr Souffle) -> a) -> a
withSouffle fp f = f $ unsafePerformPrimIO $ prim__init fp

pure : a -> PrimIO a
pure = prim__io_pure
(>>=) : (1 _ : PrimIO a) -> (1 _ : (a -> PrimIO b)) -> PrimIO b
(>>=) = prim__io_bind

private
wrapAct : (1 _ : Ptr Souffle) -> (Ptr Souffle -> PrimIO a) -> a
wrapAct suf f = assert_linear (\suf' => unsafePerformPrimIO $ f suf') suf

export
free : (1 _ : Ptr Souffle) -> ()
free suf = wrapAct suf $ \suf' => do
    _ <- prim__free suf'
    pure ()

export
loadAll : (1 _ : Ptr Souffle) -> String -> Ptr Souffle
loadAll suf dir = wrapAct suf $ \suf' => do
    _ <- prim__load_all suf' dir
    pure suf'

export
run : (1 _ : Ptr Souffle) -> Ptr Souffle
run suf = wrapAct suf $ \suf' => do
    _ <- prim__run suf'
    pure suf'

export
printAll : (1 _ : Ptr Souffle) -> String -> Ptr Souffle
printAll suf dir = wrapAct suf $ \suf' => do
    _ <- prim__print_all suf' dir
    pure suf'


