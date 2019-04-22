MIDIClient.init; MIDIIn.connectAll; ~midiOut = MIDIOut.newByName("IAC Driver", "Bus 1");
// ~midiOut.noteOn(0, 24, 90); // range is 24 to 105
// ~midiOut.noteOff(0, 24, 90);

    (
    ~createPattern = {arg seed, midinotes;
        var offset = 0.05;
        var noteEvent;

        var pitchbend = Pbind(
            \type, \midi,
            \midiout, ~midiOut,
            \midicmd, \bend,
            \chan, 0,
            \val, (8192 * Pseq([ 0, 0.5, 1, 1.5, 2 ], inf)).clip(0, 16383),
            \dur, Pseg(Pxshuf([ 1, 1/2, 1/3, 1/4, 1/5 ] * 64, inf), Pxshuf((5..17), inf), \sine),
        ).collect {|event| noteEvent = event };

        var pattern = Pbind(
            \type, \midi,
        \midiout, ~midiOut,
        \chan, 0,
        \amp, Pseg(Pseq([ 0/127, 63/127, 1/127 ], inf), Pxshuf((4..16), inf), \lin),
        \midinote, Pstutter(2, Pxshuf(midinotes, inf)),
        \timingOffset, offset,
        \dur, Pfunc { noteEvent.dur },
    );

    Pseed(seed, Ptpar([ 0.0, pitchbend, offset, pattern ], inf))
};

Pdef(\Pat1, ~createPattern.(1, (57,60..81))).play(quant: 1); 
Pdef(\Pat2, ~createPattern.(2, (56,59..80))).play(quant: 1);
Pdef(\Pat3, ~createPattern.(3, (55,58..79))).play(quant: 1);
Pdef(\Pat4, ~createPattern.(4, (54,57..78))).play(quant: 1);
Pdef(\Pat5, ~createPattern.(5, (53,55..77))).play(quant: 1);
Pdef(\Pat6, ~createPattern.(6, (52,54..76))).play(quant: 1);
Pdef(\Pat7, ~createPattern.(7, (51,53..75))).play(quant: 1);
Pdef(\Pat8, ~createPattern.(8, (50,52..74))).play(quant: 1);
Pdef(\Pat9, ~createPattern.(9, (50..73))).play(quant: 1);
Pdef(\Pat10, ~createPattern.(11, (50..72))).play(quant: 1);
Pdef(\Pat11, ~createPattern.(22, (50..71))).play(quant: 1);
Pdef(\Pat12, ~createPattern.(33, (50..70))).play(quant: 1);
Pdef(\Pat13, ~createPattern.(44, (50..69))).play(quant: 1);
Pdef(\Pat14, ~createPattern.(55, (50..68))).play(quant: 1);
Pdef(\Pat15, ~createPattern.(66, (50..67))).play(quant: 1);
Pdef(\Pat16, ~createPattern.(77, (50..66))).play(quant: 1);
Pdef(\Pat17, ~createPattern.(88, (50..65))).play(quant: 1);
Pdef(\Pat18, ~createPattern.(99, (50..64))).play(quant: 1);
Pdef(\Pat19, ~createPattern.(111, (50..63))).play(quant: 1);
Pdef(\Pat20, ~createPattern.(222, (50..62))).play(quant: 1);
Pdef(\Pat21, ~createPattern.(333, (50..61))).play(quant: 1);
Pdef(\Pat22, ~createPattern.(444, (50..60))).play(quant: 1);
Pdef(\Pat23, ~createPattern.(555, (50..59))).play(quant: 1);
Pdef(\Pat24, ~createPattern.(666, (50..58))).play(quant: 1);
Pdef(\Pat25, ~createPattern.(777, (50..57))).play(quant: 1);
Pdef(\Pat26, ~createPattern.(888, (50..56))).play(quant: 1);
Pdef(\Pat27, ~createPattern.(999, (50..55))).play(quant: 1);
Pdef(\Pat28, ~createPattern.(1111, (50..54))).play(quant: 1);
Pdef(\Pat29, ~createPattern.(2222, (50..53))).play(quant: 1);

CmdPeriod.doOnce {
    16.do {|i|
        ~midiOut.allNotesOff(i);
    };
};
)
