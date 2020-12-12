*** Variables ***

###---------------------Tiki---------------------------###
#---------------------------------------------------------
#---------------------------------------------------------

#Header common
${content_type}    application/json
${user_agent}      Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36

#Body of API Login
${grant_type}    password
${email}         minhhv96@gmail.com
${password}      abc@123

#Parameter of API Get Address
${page}     1
${limit}    10

#Body of API Update Address
${full_name}     Minh Hoàng
${company}       SmartOSC Fintech
${telephone}     0345678910
${street}        136 Hồ Tùng Mậu
${is_default}    false
${delivery_address_type}    company
${region_id}    297
${city_id}      4
${ward_id}      3580