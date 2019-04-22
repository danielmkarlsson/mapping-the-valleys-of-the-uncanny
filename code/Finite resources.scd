MIDIClient.init;

~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1");

TempoClock.default.tempo = 129/60;

~midiOut.noteOn(0, 64, 90); // send a note as a test
~midiOut.noteOff(0, 64, 90); // turn that note off
~midiOut.control(0, 14, 127); // chan, ccNum, ccVal value test, good for mapping

(
Pdef(\namedSeqA,
	Pseed(9278, Pbind(
		\type, \midi,
		\midiout, ~midiOut,
		\chan, 0,
		\midinote, Pstutter(Prand((8..29), inf), Pwrand((50..72),[7,1,6,1,5,1,4,1,3,1,2,1,1,1,1,1,1,1,1,1,1,1].normalizeSum, inf)),
		\legato, 30,
		\dur, Pseg(
			Pseq([Pstutter(Prand((1..19), 1), Pwhite(0.1, 0.5, 2))], inf),
			1,
			\sine,
			inf
		).trace,
		\amp, Pseg(Pseq([ 0.1, 1.0, 0.3], inf), Pwhite( Pwhite(5, 15, inf), Pwhite(10, 30, inf), inf), \sine),
	).play(quant: 1);
	CmdPeriod.doOnce {
		// release any hanging notes
		~midiOut.allNotesOff(0);
	};
))
)