#delimit ;
jdbc connect , jar("$jar")  driverclass("$classname")  url("$NEFSC_USERS_URL")  user("$myuid") password("$mypwd");

global firstyr 2000;
global lastyr = 2024;
clear;




/* landings */
/* leave off schema for TTS */


local sql "select * from cams_land cl
	where year>=$firstyr and year<=$lastyr" ; 


clear;
jdbc load, exec("`sql'") case(lower);
destring, replace;
notes: "`sql'";


save $data_main/cams_land_$today_date_string.dta, replace;
export delimited using  $data_main/cams_land_$today_date_string.csv, replace;


clear;
/*subtrip */

local sql "select * from cams_subtrip cst
	where year>=$firstyr and year<=$lastyr" ; 
	
	
jdbc load, exec("`sql'") case(lower);
destring, replace;
notes: "`sql'";
save $data_main/cams_subtrip_$today_date_string.dta, replace;

export delimited using  $data_main/cams_subtrip_$today_date_string.csv, replace;





/* orphan subtrip */
clear;


local sql "select * from CAMS_VTR_ORPHANS_SUBTRIP where year>=$firstyr and year<=$lastyr" ; 
	
	
jdbc load, exec("`sql'") case(lower);
destring, replace;
notes: "`sql'";


save $data_main/cams_orphan_subtrip_$today_date_string.dta, replace;
export delimited using  $data_main/cams_orphan_subtrip_$today_date_string.csv, replace;
