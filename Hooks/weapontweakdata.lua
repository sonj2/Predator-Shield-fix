Hooks:PostHook( WeaponTweakData, "init", "predator_shieldInit", function(self)
	self.predatorshield.not_allowed_in_bleedout = true
	self.predatorshield.category = "minigun"
	self.predatorshield.timers.unequip = 0.85
	self.predatorshield.timers.equip = 0.85
	self.predatorshield.CLIP_AMMO_MAX = 0
	self.predatorshield.NR_CLIPS_MAX = 0
	self.predatorshield.AMMO_MAX = self.predatorshield.CLIP_AMMO_MAX * self.predatorshield.NR_CLIPS_MAX
	self.predatorshield_secondary.not_allowed_in_bleedout = true
	self.predatorshield_secondary.category = "minigun"
	self.predatorshield_secondary.timers.unequip = 0.85
	self.predatorshield_secondary.timers.equip = 0.85
	self.predatorshield_secondary.CLIP_AMMO_MAX = 0
	self.predatorshield_secondary.NR_CLIPS_MAX = 0
	self.predatorshield_secondary.AMMO_MAX = self.predatorshield.CLIP_AMMO_MAX * self.predatorshield.NR_CLIPS_MAX
end )