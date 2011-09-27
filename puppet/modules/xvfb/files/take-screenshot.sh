#!/bin/bash

DISPLAY=:1 xwd -root -silent | xwdtopnm 2>/dev/null | pnmtopng