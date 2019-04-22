
MIDIClient.init;
MIDIIn.connectAll;
~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1");

(
var degrees = Pstep(Pseq(
[ 0, 2, 4, 11, 7, 9, 1, 3, 5, 8, 1, 3, 6, 10 ], inf).asStream, 29, inf);
var currentDegree = 0;
Pdef(\aPat,
Pseed(99246, Pbind(
    \type, \midi,
    \midiout, ~midiOut,
    \chan, 0,
    \scale, Pstutter(1,Pseq([Scale.harmonicMinor,Scale.aeolian,Scale.harmonicMajor,
            Scale.chromatic],inf)),
    \mtranspose, Pstep(Pseq([ 0, 2, -1, -2, 3, 4, 1, -3, -4 ], inf), 9, inf),
    \octave, Pstep(Pseq([ 3 ], inf), 5, inf),
    \sustain, 45,
    \amp, Pseq([ 0,Pseg(Pseq([ 0, 1, 0 ]), Pseq([ 26, 27, 28 ]), \sine),], inf),
    \degree, Pn(Plazy {|event|
    if (event.amp == 0) {currentDegree = degrees.next;};currentDegree;}),
   \dur, Pseg(Pseq([ 1.5, 3, 1, 6, 0.5, 7, 0.25 ], inf),
   Pseq([ 20, 25, 20, 15, 20, 25, 20 ], inf), \lin),
))).play(quant: 1);
CmdPeriod.doOnce {
    ~midiOut.allNotesOff(0);
};
)
