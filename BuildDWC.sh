#!/bin/sh
cp DuetAPI.xml DuetWebControl
(cd DuetWebControl; npm run build)
rm DuetWebControl/DuetAPI.xml
