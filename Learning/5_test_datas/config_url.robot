*** Variables ***
###---------------------Tiki---------------------------###
#---------------------------------------------------------
#---------------------------------------------------------

#Base URL
${tiki_base_url}             https://tiki.vn

#URI
#--- URI of login API
${post_login_url}      api/v2/tokens

#--- URI of API get list address
${get_list_address}    api/v2/me/addresses

#--- URI of API add address
${post_add_address}     api/v2/me/addresses

#--- URI of API update address
${post_update_address}    api/v2/me/addresses

###---------------------LOS---------------------------###
#---------------------------------------------------------
#---------------------------------------------------------

#Base URL
${los_base_url}             http://210.245.51.249:9001

#URI
#--- URI of login API
${post_registerloan_url}      los/loan-applications
