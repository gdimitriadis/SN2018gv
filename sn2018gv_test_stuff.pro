pro SN2018gv_test_stuff

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter
  set_plot, 'x'
  
;  file_spec1=!workspace+'SN2018gv/spectra/SN2018gv_20180121_blue_kast.txt'
;  readcol,file_spec1, wl1, flux1 ,format='d,d',comment='#',/silent
;
;  file_spec2=!workspace+'SN2018gv/spectra/SN2018gv_20180121_red_kast.txt'
;  readcol,file_spec2, wl2, flux2 ,format='d,d',comment='#',/silent
;
;  cgplot,wl1, flux1,xrange=[5500,6000]
;  
;  ind_trim1=where(wl1 ge 5670, complement=ind_g1)
;  
;  cgoplot,wl1[ind_trim1],flux1[ind_trim1],color='red'
;  
;  cgplot,wl2, flux2 ,yrange=[0,2d-14] ;,xrange=[5500,6000]
;  
;  ind_trim2=where(wl2 le 5820 or wl2 ge 9000, complement=ind_g2)
;  
;  cgoplot,wl2[ind_trim2],flux2[ind_trim2],color='red'
;  
;  wl_all=[wl1[ind_g1],wl2[ind_g2]]
;  fl_all=[flux1[ind_g1],flux2[ind_g2]]
;  
;  cgplot,wl_all,fl_all
;  
;  openw,lun,'SN2018gv_20180121_red_kast.txt',/get_lun,WIDTH=250  
;  for k=0, n_elements(wl2[ind_g2])-1 do begin
;    printf,lun,wl2[ind_g2[k]],'  ',flux2[ind_g2[k]]
;  endfor
;
;  free_lun,lun
 
 
 file_spec1=!workspace+'SN2018gv/spectra/SN2018gv_20180121_red_raw_kast.txt'
 readcol,file_spec1, wl1, flux1 ,format='d,d',comment='#',/silent
 
 cgplot,wl1, flux1/mean(flux1),xrange=[5800,6500]
 
 cgoplot,[5910,5910],[-10,10]
; ;cgoplot,[3933.566,3933.566],[-10,10]
; ;cgoplot,[3954.5098,3954.5098],[-10,10],color='red'
; 
; cgoplot,[3933.6614,3933.6614],[-10,10],color='blue'
; cgoplot,[3968.4673,3968.4673],[-10,10],color='blue'
;
; cgoplot,[3954.5098,3954.5098],[-10,10],color='orange'
; cgoplot,[3989.50017,3989.50017],[-10,10],color='orange'
;
; 
; file_spec2=!workspace+'SN2018gv/spectra/SN2018gv_20180115_lris.txt'
; readcol,file_spec2, wl2, flux2 ,format='d,d',comment='#',/silent
;
; cgoplot,wl2, flux2/mean(flux2)+1,color='red'
;  
; file_spec3=!workspace+'SN2018gv/spectra/SN2018gv_20180121_blue_kast.txt'
; readcol,file_spec3, wl3, flux3 ,format='d,d',comment='#',/silent
;
; cgoplot,wl3, flux3/mean(flux3)+1.,color='blue' 
;  
; file_spec4=!workspace+'SN2018gv/spectra/SN2018gv_20180124_b_kast.txt'
; readcol,file_spec4, wl4, flux4_foo ,format='d,d',comment='#',/silent
; 
; flux4=1d-15*flux4_foo
; 
; cgoplot,wl4, flux4/mean(flux4)-0.1,color='orange'
;  
; file_spec5=!workspace+'SN2018gv/spectra/SN2018gv_20180123_lco_snex.txt'
; readcol,file_spec5, wl5, flux5 ,format='d,d',comment='#',/silent
;
; cgoplot,wl5, flux5/mean(flux5)-1.0,color='cyan'
; 
; file_spec6=!workspace+'SN2018gv/spectra/SN2018gv_20180117_lco_snex.txt'
; readcol,file_spec6, wl6, flux6 ,format='d,d',comment='#',/silent
;
; cgoplot,wl6, flux6/mean(flux6),color='magenta'
 
 
; file_spec1=!workspace+'SN2018gv/spectra/SN2018gv_20180124_b_kast.txt'
; readcol,file_spec1, wl1, flux1 ,format='d,d',comment='#',/silent
;
; cgplot,wl1, flux1/mean(flux1)-0.1,xrange=[5500,6500] ;,yrange=[1.5,4]
;
; file_spec2=!workspace+'SN2018gv/spectra/SN2018gv_20180115_lris.txt'
; readcol,file_spec2, wl2, flux2 ,format='d,d',comment='#',/silent
;
; cgoplot,wl2, flux2/mean(flux2)-0.2,color='red'
;;
;; file_spec3=!workspace+'SN2018gv/spectra/SN2018gv_20180121_blue_kast.txt'
;; readcol,file_spec3, wl3, flux3 ,format='d,d',comment='#',/silent
;;
;; cgoplot,wl3, flux3/mean(flux3)+1.3,color='blue'
;;
; file_spec4=!workspace+'SN2018gv/spectra/SN2018gv_20180125_lco_snex.txt'
; readcol,file_spec4, wl4, flux4 ,format='d,d',comment='#',/silent
;
; cgoplot,wl4, flux4/mean(flux4),color='orange'
;
; file_spec5=!workspace+'SN2018gv/spectra/SN2018gv_20180123_lco_snex.txt'
; readcol,file_spec5, wl5, flux5 ,format='d,d',comment='#',/silent
;
; cgoplot,wl5, flux5/mean(flux5),color='cyan'
  
end