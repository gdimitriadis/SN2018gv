pro SN2018gv_carbon_measurements

  COMPILE_OPT IDL2, STRICTARRSUBS
  COMMON filter_info,master_filter

  set_plot, 'x'
  
  rest_wl_carbon=6580.0d0
  speed_of_light=2.99792d5
  
  file_spec_log=!workspace+'SN2018gv/spectra/SN2018gv_spec_log.txt'
  readcol,file_spec_log,spec_name,spec_mjd,spec_airmass, spec_source,format='a,d,d,a',comment='#',/silent
  
  print,spec_mjd[14]
    
  file_spec=!workspace+'SN2018gv/spectra/'+spec_name[14]
  readcol,file_spec, wl, flux ,format='d,d',comment='#',/silent 
  
  z=0.0053d0

  wl_rest=wl/(1.+z)

  fl=flux/1d-15
  
;  cgplot,wl_rest,fl,xrange=[5900,6600]
;  
;  ind_fit=where(wl_rest ge 6150. and wl_rest le 6350.)
;  cgoplot,wl_rest[ind_fit],fl[ind_fit], color='red'
;  
;  res=poly_fit(wl_rest[ind_fit],fl[ind_fit],3)
;  res_plot=poly(wl_rest[ind_fit],res)
;  cgoplot,wl_rest[ind_fit],res_plot,color='blue'
  
  lower1=6290.0
  lower2=6310.0
  upper1=6370.0
  upper2=6390.0
  
  ind_bl=where(wl_rest ge lower1 and wl_rest le lower2)
  ind_bu=where(wl_rest ge upper1 and wl_rest le upper2)
  
  ind_fit=where(wl_rest ge lower2 and wl_rest le upper1)

  
  bg_carbon=fit_background_noerr(wl_rest,fl,lower1,lower2,upper1,upper2)
  norm_flux=fl/(bg_carbon[0]+bg_carbon[1]*wl_rest)
  
  cgplot,wl_rest,norm_flux,xrange=[5900,6600],yrange=[0,2]
  cgoplot,wl_rest[ind_bl],norm_flux[ind_bl],color='magenta'
  cgoplot,wl_rest[ind_bu],norm_flux[ind_bu],color='magenta'
  cgoplot,wl_rest[ind_fit],norm_flux[ind_fit], color='blue'
  
  stop
  
  res=poly_fit(wl_rest[ind_fit],norm_flux[ind_fit],2)
  res_plot=poly(wl_rest[ind_fit],res)
  cgoplot,wl_rest[ind_fit],res_plot,color='red'

  foo=wl_rest[ind_fit[where(res_plot eq min(res_plot)  )]]

  zmeas=(foo-rest_wl_carbon)/rest_wl_carbon
  vel_min=(((zmeas+1.0)^2-1.0)*speed_of_light/(1.+(1.+zmeas)^2))
  print,vel_min
  
  zmeas=(wl_rest-rest_wl_carbon)/rest_wl_carbon
  vel_arr=(((zmeas+1.0)^2-1.0)*speed_of_light/(1.+(1.+zmeas)^2))
;  stop
  cgplot,vel_arr,norm_flux,xrange=[-30000,0],yrange=[0,2]
  
  ind_fit=where(vel_arr ge -15000. and vel_arr le -10000.)

  res=poly_fit(vel_arr[ind_fit],norm_flux[ind_fit],2)
  res_plot=poly(vel_arr[ind_fit],res)
  cgoplot,vel_arr[ind_fit],res_plot,color='red'
  
  foo=vel_arr[ind_fit[where(res_plot eq min(res_plot)  )]]
  cgoplot,[foo,foo],[-10,10]

  print,foo
  
end