//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/projects/p20742/tools/buildPipelineScripts.pl \
-t RNA \
-o /projects/p30068/POP3Colitis/output \
-g mm10 \
-f /projects/p30068/POP3Colitis \
-c /projects/p30068/POP3Colitis/Comparisons_Rojo.csv \
-uploadASHtracks 0 \
-runAlign 1 \
-runEdgeR 1 \
    >& buildPipelineScripts.testRNA.log &