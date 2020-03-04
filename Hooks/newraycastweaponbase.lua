local data_calculate_ammo_max_per_clip = NewRaycastWeaponBase.calculate_ammo_max_per_clip
function NewRaycastWeaponBase:calculate_ammo_max_per_clip()
    local ammo = data_calculate_ammo_max_per_clip(self)
    if self:is_category("akimbo") and managers.player:player_unit():inventory():akimbo_shield_check()then
        log("akimbo shield ammo / 2")
        ammo = ammo / 2
    end
    return ammo
end