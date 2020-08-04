Copy datasets from one library to another while keeping just two variables                                             
                                                                                                                       
github                                                                                                                 
https://tinyurl.com/y2p47wzo                                                                                           
https://github.com/rogerjdeangelis/utl-copy-datasets-from-one-library-to-another-while-keeping-just-two-variables      
                                                                                                                       
SAS Forum                                                                                                              
https://tinyurl.com/y5czhvl8                                                                                           
https://communities.sas.com/t5/SAS-Programming/Do-loop-over-multiple-tables/m-p/673372                                 
                                                                                                                       
    Two Solutions                                                                                                      
         a. do_over                                                                                                    
         b. dosubl (with error checking)                                                                               
                                                                                                                       
/*                   _                                                                                                 
(_)_ __  _ __  _   _| |_                                                                                               
| | `_ \| `_ \| | | | __|                                                                                              
| | | | | |_) | |_| | |_                                                                                               
|_|_| |_| .__/ \__,_|\__|                                                                                              
        |_|                                                                                                            
*/                                                                                                                     
                                                                                                                       
data                                                                                                                   
   udda2002                                                                                                            
   udda2003                                                                                                            
   udda2004                                                                                                            
   udda2005                                                                                                            
   udda2006;                                                                                                           
  set sashelp.class;                                                                                                   
run;quit;                                                                                                              
                                                                                                                       
FOUR DATASETS IN WORK LIBRARY                                                                                          
                                                                                                                       
WORK.UDDA2002 total obs=19                                                                                             
                                                                                                                       
Obs    NAME       SEX    AGE    HEIGHT  WEIGHT                                                                         
                                                                                                                       
  1    Joyce       F      11     51.3     50.5                                                                         
  2    Louise      F      12     56.3     77.0                                                                         
  3    Alice       F      13     56.5     84.0                                                                         
 ...                                                                                                                   
                                                                                                                       
WORK.UDDA2006 total obs=19                                                                                             
                                                                                                                       
Obs    NAME       SEX    AGE    HEIGHT  WEIGHT                                                                         
                                                                                                                       
  1    Joyce       F      11     51.3     50.5                                                                         
  2    Louise      F      12     56.3     77.0                                                                         
  3    Alice       F      13     56.5     84.0                                                                         
                                                                                                                       
/*           _               _                                                                                         
  ___  _   _| |_ _ __  _   _| |_                                                                                       
 / _ \| | | | __| `_ \| | | | __|                                                                                      
| (_) | |_| | |_| |_) | |_| | |_                                                                                       
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                      
                |_|                                                                                                    
*/                                                                                                                     
                                                                                                                       
WORK.LOG total obs=5                                                                                                   
                                                                                                                       
Obs    YEAR                          STATUS                                                                            
                                                                                                                       
 1     2002     work.udda2002 SUCESSFULLY copied to sd1.udda2002                                                       
 2     2003     work.udda2003 SUCESSFULLY copied to sd1.udda2003                                                       
 3     2004     work.udda2004 SUCESSFULLY copied to sd1.udda2004                                                       
 4     2005     work.udda2005 SUCESSFULLY copied to sd1.udda2005                                                       
 5     2006     work.udda2006 SUCESSFULLY copied to sd1.udda2006                                                       
                                                                                                                       
                                                                                                                       
FOUR DATASETS IN SD1 LIBRARY WITHOUT VAIABLES AGE HEIGHT WEIGHT                                                        
                                                                                                                       
d:/sd1                                                                                                                 
                                                                                                                       
libname sd1 "d:/sd1";                                                                                                  
                                                                                                                       
SD1.UDDA2002 total obs=19                                                                                              
                                                                                                                       
Obs    NAME       SEX                                                                                                  
                                                                                                                       
  1    Joyce       F                                                                                                   
  2    Louise      F                                                                                                   
  3    Alice       F                                                                                                   
 ...                                                                                                                   
                                                                                                                       
SD1.UDDA2006 total obs=19                                                                                              
                                                                                                                       
Obs    NAME       SEX                                                                                                  
                                                                                                                       
  1    Joyce       F                                                                                                   
  2    Louise      F                                                                                                   
  3    Alice       F                                                                                                   
                                                                                                                       
                                                                                                                       
/*         _       _   _                                                                                               
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                               
/ __|/ _ \| | | | | __| |/ _ \| `_ \/ __|                                                                              
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                              
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                              
     _                                                                                                                 
  __| | ___     _____   _____ _ __                                                                                     
 / _` |/ _ \   / _ \ \ / / _ \ `__|                                                                                    
| (_| | (_) | | (_) \ V /  __/ |                                                                                       
 \__,_|\___/___\___/ \_/ \___|_|                                                                                       
          |_____|                                                                                                      
*/                                                                                                                     
                                                                                                                       
data                                                                                                                   
   udda2002                                                                                                            
   udda2003                                                                                                            
   udda2004                                                                                                            
   udda2005                                                                                                            
   udda2006;                                                                                                           
  set sashelp.class;                                                                                                   
run;quit;                                                                                                              
                                                                                                                       
libname sd1 "d:/sd1";                                                                                                  
                                                                                                                       
* probably a good thing to do regardless of algorithm;                                                                 
proc datasets lib=sd1;                                                                                                 
  delete udda:;                                                                                                        
run;quit;                                                                                                              
                                                                                                                       
* Just two call;                                                                                                       
%array(yrs,values=udda2002-udda2006);                                                                                  
%do_over(yrs,phrase=%str(                                                                                              
    proc append base=sd1.? data=?(keep=name sex);                                                                      
    run;quit;));                                                                                                       
                                                                                                                       
/*   _                 _     _                                                                                         
  __| | ___  ___ _   _| |__ | |                                                                                        
 / _` |/ _ \/ __| | | | `_ \| |                                                                                        
| (_| | (_) \__ \ |_| | |_) | |                                                                                        
 \__,_|\___/|___/\__,_|_.__/|_|                                                                                        
                                                                                                                       
*/                                                                                                                     
                                                                                                                       
data                                                                                                                   
   udda2002                                                                                                            
   udda2003                                                                                                            
   udda2004                                                                                                            
   udda2005                                                                                                            
   udda2006;                                                                                                           
  set sashelp.class;                                                                                                   
run;quit;                                                                                                              
                                                                                                                       
libname sd1 "d:/sd1";                                                                                                  
                                                                                                                       
* probably a good thing to do regardless of algorithm;                                                                 
proc datasets lib=sd1;                                                                                                 
  delete udda:;                                                                                                        
run;quit;                                                                                                              
                                                                                                                       
* has error checking;                                                                                                  
data log ;                                                                                                             
                                                                                                                       
  do year=2002 to 2006;                                                                                                
                                                                                                                       
    call symputx("yr",year);                                                                                           
                                                                                                                       
    rc=dosubl('                                                                                                        
       data sd1.udda&yr;                                                                                               
          set udda&yr (keep=name sex);                                                                                 
       run;quit;                                                                                                       
       %let cc=&syserr;                                                                                                
       ');                                                                                                             
       * note I use the hiddon dragon with cats to add spaces alt-255;                                                 
       if symgetn("cc")=0 then status=cats("work.udda",year," SUCESSFULLY copied to sd1.udda",year);                   
       else status=cats("work.udda",year," FAILED to copy sd1.udda",year);                                             
       output;                                                                                                         
  end;                                                                                                                 
  stop;                                                                                                                
run;quit;                                                                                                              
                                                                                                                       
