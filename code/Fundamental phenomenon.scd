MIDIClient.init;

~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1");

TempoClock.default.tempo = 126/60;

~midiOut.noteOn(0, 50, 90); // send a note as a test
~midiOut.noteOff(0, 64, 90); // turn that note off
~midiOut.control(0, 14, 127); // chan, ccNum, ccVal value test, good for mapping

(
Pdef(\nameA,
Pbind(
    \type, \midi,
    \midiout, ~midiOut,
    \chan, 0,
	\midinote, 50,
	\dur, Pseg(
		Pseq([Pstutter(Prand((6..12), 1), Pwhite(1.75, 3.5, 8))], inf),
		3,
		\sine,
		inf
	).trace,
	\amp, Pseg(Pseq([ 0.01, 0.7, 0.01], inf), Pwhite( 15, 30.0, inf), \sine),
).play(quant: 1);
CmdPeriod.doOnce {
    // release any hanging notes
    ~midiOut.allNotesOff(0);
};
)
)

(
Pdef(\nameB,
Pbind(
    \type, \midi,
    \midiout, ~midiOut,
    \chan, 1,
	\midinote, 48,
	\dur, Pseg(
		Pseq([Pstutter(Prand((5..17), 1), Pwhite(1.75, 3, 9))], inf),
		4,
		\sine,
		inf
	).trace,
	\amp, Pseg(Pseq([ 0.01, 0.7, 0.01], inf), Pwhite( 20, 30.0, inf), \sine),
).play(quant: 1);
CmdPeriod.doOnce {
    // release any hanging notes
    ~midiOut.allNotesOff(0);
};
)
)

(
Pdef(\nameC,
Pbind(
    \type, \midi,
    \midiout, ~midiOut,
    \chan, 2,
	\midinote, 53,
	\dur, Pseg(
		Pseq([Pstutter(Prand((4..14), 1), Pwhite(1.75, 3.5, 10))], inf),
		2,
		\sine,
		inf
	).trace,
	\amp, Pseg(Pseq([ 0.01, 0.7, 0.01], inf), Pwhite( 25.0, 30.0, inf), \sine),
).play(quant: 1);
CmdPeriod.doOnce {
    // release any hanging notes
    ~midiOut.allNotesOff(0);
};
)
)

(
Pdef(\nameD,
Pbind(
    \type, \midi,
    \midiout, ~midiOut,
    \chan, 3,
	\midinote, 51,
	\dur, Pseg(
		Pseq([Pstutter(Prand((3..9), 1), Pwhite(2, 3.5, 11))], inf),
		5,
		\sine,
		inf
	).trace,
	\amp, Pseg(Pseq([ 0.01, 0.7, 0.01], inf), Pwhite( 27.5, 40.0, inf), \sine),
).play(quant: 1);
CmdPeriod.doOnce {
    // release any hanging notes
    ~midiOut.allNotesOff(0);
};
)
)