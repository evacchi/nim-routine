import nimroutine\routine, math, times, sequtils, os

proc quickSort[T](a: ptr seq[T], lo, hi: int, deep: int) {.routine.}=
    if hi <= lo: return
    let pivot = a[int((lo+hi)/2)]
    var (i, j) = (lo, hi)

    while i <= j:
        if a[i] < pivot:
            inc i
        elif a[j] > pivot:
            dec j
        elif i <= j:
            swap a[i], a[j]
            inc i
            dec j
    discard pRun(quickSort[int], (a, lo, j, deep+1))
    discard pRun(quickSort[int], (a, i, hi, deep+1))

proc quickSort*(a: ptr seq[int]) =
    pRun quickSort[int], (a, a[].low, a[].high, 0)

randomize(int(epochTime()))
var a = newSeqWith(100, random(100))

echo a
quickSort a.addr
waitAllRoutine()
echo a
