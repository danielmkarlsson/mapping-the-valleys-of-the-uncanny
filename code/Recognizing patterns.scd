(
MIDIClient.init;
MIDIIn.connectAll;
~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1");
)

~midiOut.noteOn(0, 64, 90); // range is 24 to 105
~midiOut.noteOff(0, 64, 90);
~midiOut.control(0, 14, 127); // chan, ccNum, ccVal


(
~createPattern = {arg seed, midinotes, ctlNum, ccVal;
    var pattern = Pbind(
        \type, \midi,
        \midiout, ~midiOut,
        \chan, 0,
        \amp, Pseg(Pseq([ 0/127, 127/127, 1/127 ]), Pxshuf((5..20)), \lin),
        \midinote, Pstutter(91, Pxshuf(midinotes, inf)),
        \dur, Pseg(Pxshuf(( 1/2, 1/3 .. 1/13 ), inf), Pxshuf((5..17), inf), \sine),
    );
    Pseed(seed, Pseq([ pattern ], inf));
};

Pdef(\Pat1, ~createPattern.(111, (48..90))).play(quant: 1);
Pdef(\Pat2, ~createPattern.(222, (48..90))).play(quant: 1);
Pdef(\Pat3, ~createPattern.(333, (48..90))).play(quant: 1);
Pdef(\Pat4, ~createPattern.(444, (48..90))).play(quant: 1);
Pdef(\Pat5, ~createPattern.(555, (48..90))).play(quant: 1);
Pdef(\Pat6, ~createPattern.(666, (48..90))).play(quant: 1);
Pdef(\Pat7, ~createPattern.(777, (48..90))).play(quant: 1);
Pdef(\Pat8, ~createPattern.(888, (48..90))).play(quant: 1);
)