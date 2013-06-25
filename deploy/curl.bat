CALL %BIN_FOLDER%\curl\curl.exe -v http://%SERVER%/_service/status -f -H "Host: %HOST%"
CALL %BIN_FOLDER%\curl\curl.exe -v http://%SERVER%/purchase/release/1234 -f -H "Host: %HOST%"
CALL %BIN_FOLDER%\curl\curl.exe -v http://%SERVER%/purchase/track/12345 -f -H "Host: %HOST%"

CALL %BIN_FOLDER%\curl\curl.exe -v http://%SERVER%/m/purchase/release/1234 -f -H "Host: %HOST%"
CALL %BIN_FOLDER%\curl\curl.exe -v http://%SERVER%/m/purchase/track/12345 -f -H "Host: %HOST%"