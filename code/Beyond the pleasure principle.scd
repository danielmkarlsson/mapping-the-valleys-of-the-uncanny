MIDIClient.init;

~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1");

TempoClock.default.tempo = 107/60;

~midiOut.noteOn(0, 64, 90); // send a note as a test
~midiOut.noteOff(0, 64, 90); // turn that note off
~midiOut.control(0, 14, 127); // chan, ccNum, ccVal value test, good for mapping

(
Pdef(\namedSeqA,
	Pseed(5916, Pbind(
		\type, \midi,
		\midiout, ~midiOut,
		//\chan, 0,
		\chan, Pstutter(Prand((1..4), inf), Pxshuf((0..5), inf)),
		\midinote, Pstutter(Prand((1..40), inf), Prand((36..88), inf)),
		\dur, Pseg(Pseq([Pstutter(Prand((2..9), 1), Pwhite((1/10), (1/4), 1))], inf),2,\sine,inf),
        \amp, Pseg(Pseq([Pstutter(Prand((2..13), 1), Pwhite(0.1, 1.0, 1))], inf),1,\sine,inf)
	).play(quant: 1);
	CmdPeriod.doOnce {
		// release any hanging notes
		~midiOut.allNotesOff(0);
	};
))
)
