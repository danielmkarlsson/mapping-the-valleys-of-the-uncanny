MIDIClient.init;

~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1");

TempoClock.default.tempo = 129/60;

~midiOut.noteOn(0, 64, 90); // send a note as a test
~midiOut.noteOff(0, 64, 90); // turn that note off
~midiOut.control(0, 14, 127); // chan, ccNum, ccVal value test, good for mapping

(
Pdef(\namedSeqA,
	Pseed(1748, Pbind(
		\type, \midi,
		\midiout, ~midiOut,
		\chan, 0,
		\scale, Scale.aeolian,
		\degree, Pstutter(Prand((1..9), inf), Pwrand((0..7),[5,1,4,1,3,1,2,1].normalizeSum, inf)),
		\octave, Pstutter(Prand((3..7), inf), Pwrand((3..4),[1,2].normalizeSum, inf)),
		\legato, 25,
		\dur, Pseg(
			Pseq([Pstutter(Prand((1..19), 1), Pwhite(0.04, 0.4, 2))], inf),
			1,
			\sine,
			inf
		).trace,
		\amp, Pseg(Pseq([ 0.2, 1.0, 0.2 ], inf), Pwhite( Pwhite(5, 30, inf), Pwhite(10, 60, inf), inf), \sine),
	).play(quant: 1);
	CmdPeriod.doOnce {
		// release any hanging notes
		~midiOut.allNotesOff(0);
	};
))
)