pro SN2018gv_compare_spectra

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter
  set_plot, 'x'


  sn18gv_z=0.0053d0
  sn18gv_ebv_mw=0.0497d0
  
  file_spec_log=!workspace+'SN2018gv/spectra/SN2018gv_spec_log.txt'
  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass, spec_source,format='a,d,d,a',comment='#',/silent
  
  forprint,spec_name,spec_mjd
  
  cgplot,0, 0, /nodata, xrange=[3000,10000],yrange=[-2,6]
  
  cgoplot,[6500,6600],[0,0],thick=5
  
;  ;;; -11 fe ;;;
;  
;  file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/mSN2018gv_20180121_br_kast.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;  
;  wl_rest=wl/(1.+sn18gv_z)
;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;  
;  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;  
;  cgoplot,wl_rest, flux/mean(flux[ind_av]),color='black'
;  
;;  ;;;;;;;;;;;;;;;;;
;;  
;;  file_spec=!workspace+'SN2018gv/spectra/trimmed_spectra/tSN2018gv_20180121_br_kast.txt'
;;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;;
;;  wl_rest=wl/(1.+sn18gv_z)
;;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;;
;;  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;;
;;  cgoplot,wl_rest, flux/mean(flux[ind_av])+1,color='red'
;;  
;;  ;;;;;;;;;;;;;;;;;
;  
;  file_spec=!workspace+'SN2018gv/spectra/comparisons/11fe_spectra/11fe_20110831_-11.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;  
;  sn11fe_z=0.000804d0
;  sn18gv_ebv_mw=0.0077d0
;
;  wl_rest=wl/(1.+sn11fe_z)
;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;  
;  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;
;  
;  cgoplot,wl, flux/mean(flux[ind_av]),color='grey'
  
  
;  ;;; -12 fe ;;;
;  
;  file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/mSN2018gv_20180120_lco_snex.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;
;  wl_rest=wl/(1.+sn18gv_z)
;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;
;  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;
;  cgoplot,wl_rest, flux/mean(flux[ind_av])+1.5,color='black', xrange=[3000,10000]
;
;    ;;;;;;;;;;;;;;;;;
;  
;    file_spec=!workspace+'SN2018gv/spectra/trimmed_spectra/tSN2018gv_20180120_lco_snex.txt'
;    readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;  
;    wl_rest=wl/(1.+sn18gv_z)
;    ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;  
;    ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;  
;    cgoplot,wl_rest, flux/mean(flux[ind_av])+1.5,color='red'
;  
;    ;;;;;;;;;;;;;;;;;
;
;  file_spec=!workspace+'SN2018gv/spectra/comparisons/11fe_spectra/11fe_20110830_-12.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;
;  sn11fe_z=0.000804d0
;  sn18gv_ebv_mw=0.0077d0
;
;  wl_rest=wl/(1.+sn11fe_z)
;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;
;  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;
;
;  cgoplot,wl, flux/mean(flux[ind_av])+1.5,color='grey'
  
;  ;;; -9 fe ;;;
;
;  file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/mSN2018gv_20180123_lco_snex.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;
;  wl_rest=wl/(1.+sn18gv_z)
;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;
;  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;
;  cgoplot,wl_rest, flux/mean(flux[ind_av])-1.5,color='black', xrange=[3000,10000]
;
;  ;;;;;;;;;;;;;;;;;
;
;  file_spec=!workspace+'SN2018gv/spectra/trimmed_spectra/tSN2018gv_20180123_lco_snex.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;
;  wl_rest=wl/(1.+sn18gv_z)
;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;
;  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;
;  cgoplot,wl_rest, flux/mean(flux[ind_av])-1.5,color='red'
;
;  ;;;;;;;;;;;;;;;;;
;
;  file_spec=!workspace+'SN2018gv/spectra/comparisons/11fe_spectra/11fe_20110902_-9.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;
;  sn11fe_z=0.000804d0
;  sn18gv_ebv_mw=0.0077d0
;
;  wl_rest=wl/(1.+sn11fe_z)
;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;
;  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;
;
;  cgoplot,wl, flux/mean(flux[ind_av])-1.5,color='grey'

  ;;; -3 fe ;;;

  file_spec=!workspace+'SN2018gv/spectra/mangled_spectra/mSN2018gv_20180129_lco_snex.txt'
  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent

  wl_rest=wl/(1.+sn18gv_z)
  ccm_unred,wl_rest,flux,sn18gv_ebv_mw

  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)

  cgoplot,wl_rest, flux/mean(flux[ind_av])-1.5,color='black', xrange=[3000,10000]

;  ;;;;;;;;;;;;;;;;;
;
;  file_spec=!workspace+'SN2018gv/spectra/trimmed_spectra/tSN2018gv_20180129_lco_snex.txt'
;  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent
;
;  wl_rest=wl/(1.+sn18gv_z)
;  ccm_unred,wl_rest,flux,sn18gv_ebv_mw
;
;  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)
;
;  cgoplot,wl_rest, flux/mean(flux[ind_av])-1.5,color='red'
;
;  ;;;;;;;;;;;;;;;;;

  file_spec=!workspace+'SN2018gv/spectra/comparisons/11fe_spectra/11fe_20110908_-3.txt'
  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent

  sn11fe_z=0.000804d0
  sn18gv_ebv_mw=0.0077d0

  wl_rest=wl/(1.+sn11fe_z)
  ccm_unred,wl_rest,flux,sn18gv_ebv_mw

  ind_av=where(wl_rest ge 6500 and wl_rest le 6600)


  cgoplot,wl, flux/mean(flux[ind_av])-1.5,color='grey'
  
  
  
end