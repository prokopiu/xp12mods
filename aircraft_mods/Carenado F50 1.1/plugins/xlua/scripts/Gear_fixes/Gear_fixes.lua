local GotValues = 0
local SetHSI = 0
ngNoseGearSteer = find_dataref("sim/flightmodel2/gear/tire_steer_actual_deg[0]") 
ngRotationAngle = find_dataref("sim/flightmodel2/gear/tire_rotation_angle_deg[0]") 
rgRotationAngle = find_dataref("sim/flightmodel2/gear/tire_rotation_angle_deg[1]") 
lgRotationAngle = find_dataref("sim/flightmodel2/gear/tire_rotation_angle_deg[2]") 
ngDeployRatio   = find_dataref("sim/flightmodel2/gear/deploy_ratio[0]") 
rgDeployRatio   = find_dataref("sim/flightmodel2/gear/deploy_ratio[1]") 
lgDeployRatio   = find_dataref("sim/flightmodel2/gear/deploy_ratio[2]") 
gearHandlePos   = find_dataref("sim/cockpit2/controls/gear_handle_request") 
electric_trim_on= find_dataref("sim/cockpit2/autopilot/electric_trim_on")

function gear_deploy_handler()
  if GotValues == 0 then
    noseGearSteer    = find_dataref("thranda/anim/noseGearSteer")
    noseGearDeploy   = find_dataref("thranda/anim/noseGearDeploy")
    leftGearDeploy   = find_dataref("thranda/anim/leftGearDeploy")
    rightGearDeploy  = find_dataref("thranda/anim/rightGearDeploy")
    noseGearRotate   = find_dataref("thranda/anim/noseGearRot")
    leftGearRotate   = find_dataref("thranda/anim/leftGearRot")
    rightGearRotate  = find_dataref("thranda/anim/rightGearRot")
    GotValues = 1
  end
  if noseGearDeploy ~= (1 - ngDeployRatio) then
    noseGearDeploy  = 1 - ngDeployRatio
  end
  if leftGearDeploy ~= lgDeployRatio then
    leftGearDeploy  = 1 - lgDeployRatio
  end
  if rightGearDeploy ~= rgDeployRatio then
    rightGearDeploy = 1 - rgDeployRatio
  end
  noseGearRotate   = ngRotationAngle
  leftGearRotate   = lgRotationAngle
  rightGearRotate  = rgRotationAngle
  noseGearSteer = ngNoseGearSteer
  electric_trim_on = 1
end

function flight_start()
  if SetHSI == 0 then
    SetHSI = 1
    HSISourceSelectPilot   = find_dataref("sim/cockpit2/radios/actuators/HSI_source_select_pilot")
    HSISourceSelectCoPilot = find_dataref("sim/cockpit2/radios/actuators/HSI_source_select_copilot")
  end
  HSISourceSelectPilot   = 2
  HSISourceSelectCoPilot = 2   
end

function after_physics() 
  gear_deploy_handler()
end 
