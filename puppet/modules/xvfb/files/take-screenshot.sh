#!/bin/bash

DISPLAY=:1 xwd -root -silent | xwdtopnm | pnmtojpeg 