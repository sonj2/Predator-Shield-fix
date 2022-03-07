local data_calculate_ammo_max_per_clip = NewRaycastWeaponBase.calculate_ammo_max_per_clip
Hooks:PostHook(NewRaycastWeaponBase, "calculate_ammo_max_per_clip", "NewRaycastWeaponBase:calculate_ammo_max_per_clip", function(self, ...)
    if BLT.Mods:GetModByName("WeaponLib") then
        return
    else
        local ammo = data_calculate_ammo_max_per_clip(self)
        if self:is_category("akimbo") and managers.player:player_unit():inventory():akimbo_shield_check()then
            log("akimbo shield ammo / 2")
            ammo = ammo / 2
        end
        ammo = math.floor(ammo)
        return ammo
    end
end)

--[[function NewRaycastWeaponBase:calculate_ammo_max_per_clip()
    local ammo = data_calculate_ammo_max_per_clip(self)
    if self:is_category("akimbo") and managers.player:player_unit():inventory():akimbo_shield_check()then
        log("akimbo shield ammo / 2")
        ammo = ammo / 2
    end
    return ammo
end]]
--Preferring Weaponlib method, since it shows the reduction in the inventory