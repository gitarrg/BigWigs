
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Stix Bunkjunker", 2769, 2642)
if not mod then return end
mod:RegisterEnableMob(230322) -- Stix Bunkjunker
mod:SetEncounterID(3012)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Locals
--

local electromagneticSortingCount = 1
local incineratorCount = 1
local demolishCount = 1
local meltdownCount = 1
local powercoilCount = 1

local muffledDoomsplosionCount = 0

local mobCollector = {}
local mobMarks = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ball_size_medium = "Medium Ball!"
	L.ball_size_large = "Large Ball!"
	L.rolled_on_you = "%s rolled over YOU"
	L.rolled_from_you = "Rolled over %s"
	L.garbage_dump_message = "YOU hit BOSS for %s"

	L.electromagnetic_sorting = "Sorting" -- Short for Electromagnetic Sorting
	L.muffled_doomsplosion = "Bomb Soaked"
	L.incinerator = "Fire Circles"
	L.landing = "Landing" -- Landing down from the sky
end

--------------------------------------------------------------------------------
-- Initialization
--

local territorialBombshellMarker = mod:AddMarkerOption(false, "npc", 1, -30451, 8, 7, 6, 5, 4)
function mod:GetOptions()
	return {
		territorialBombshellMarker,
		464399, -- Electromagnetic Sorting
			{461536, "ME_ONLY_EMPHASIZE"}, -- Rolling Rubbish
				465741, -- Garbage Dump
				465611, -- Rolled!
			464854, -- Garbage Pile
				465747, -- Muffled Doomsplosion
				1217975, -- Doomsploded
			-- Territorial Bombshell -- XXX announce/count deaths? show bar until all dead?

		-- Cleanup Crew
			-- Scrapmaster
			1219384, -- Scrap Rockets
			1220648, -- Marked for Recycling
			-- Junkyard Hyena
			466748, -- Infected Bite

		-- Incinerator
		464149, -- Incinerator
			472893, -- Incineration
			464248, -- Hot Garbage

		-- Demolish
		{464112, "TANK"}, -- Demolish
		{1217954, "TANK_HEALER"}, -- Meltdown

		-- Overdrive
		467117, -- Overdrive
			{467135, "CASTBAR"}, -- Trash Compactor
		-- Mythic
		1218704, -- Prototype Powercoil
	},{ -- Sections
		[1219384] = -30533, -- Cleanup Crew
		-- break up the list with dividers (the headers are options, and showing the same text twice is awkward)
		-- [466849] = "", -- Cleanup Crew
		[464149] = "", -- Incinerator
		[464112] = "", -- Demolish
		[467117] = "", -- Overdrive
		[1218704] = CL.mythic,
	},{ -- Renames
		[464399] = L.electromagnetic_sorting, -- Electromagnetic Sorting (Balls + Adds)
		[465747] = L.muffled_doomsplosion, -- Muuffled Doomsplosion (Bomb Soaked)
		[464149] = L.incinerator, -- Incinerator (Fire Circles)
		[467135] = L.landing, -- Trash Compactor (Landing)
	}
end

function mod:OnRegister()
	self:SetSpellRename(464399, L.electromagnetic_sorting) -- Electromagnetic Sorting (Balls + Adds)
	self:SetSpellRename(464149, L.incinerator) -- Incinerator (Fire Circles)
	self:SetSpellRename(467109, L.landing) -- Trash Compactor (Landing)
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "ElectromagneticSorting", 464399)
	self:Log("SPELL_AURA_APPLIED", "SortedApplied", 465346) -- These players will become Rolling Rubbish
	self:Log("SPELL_AURA_APPLIED", "RollingRubbishApplied", 461536)
	self:Log("SPELL_AURA_REMOVED", "RollingRubbishRemoved", 461536)
	self:Log("SPELL_AURA_APPLIED", "RolledApplied", 465611)
	self:Log("SPELL_AURA_APPLIED", "DoomsplodedApplied", 1217975)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DoomsplodedApplied", 1217975)
	self:Log("SPELL_AURA_APPLIED", "ShortFuseApplied", 473115) -- (Territorial Bombshell)
	self:Log("SPELL_CAST_SUCCESS", "ScrapRockets", 1219384)
	self:Log("SPELL_AURA_APPLIED", "InfectedBiteApplied", 466748)
	self:Log("SPELL_AURA_APPLIED_DOSE", "InfectedBiteApplied", 466748)
	self:Log("SPELL_CAST_SUCCESS", "Incinerator", 464149)
	self:Log("SPELL_AURA_APPLIED", "IncinerationApplied", 472893)
	self:Log("SPELL_CAST_START", "Demolish", 464112)
	self:Log("SPELL_AURA_APPLIED", "DemolishApplied", 464112)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DemolishApplied", 464112)
	self:Log("SPELL_CAST_SUCCESS", "Meltdown", 1217954)

	self:Log("SPELL_CAST_START", "Overdrive", 467117)
	self:Log("SPELL_CAST_START", "TrashCompactor", 467109)

	self:Log("SPELL_DAMAGE", "GarbageDumpDamage", 465741) -- for Rolling Rubbish hitting the boss
	self:Log("SPELL_DAMAGE", "MuffledDoomsplosionDamage", 465747) -- for Rolling Rubbish picking up Doomsplosives
	self:Log("SPELL_MISSED", "MuffledDoomsplosionDamage", 465747)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "MarkedForRecyclingApplied", 1220648)
	self:Log("SPELL_AURA_REMOVED", "MarkedForRecyclingRemoved", 1220648)
	self:Log("SPELL_AURA_APPLIED", "PrototypePowercoilApplied", 1218704)
	self:Log("SPELL_AURA_REMOVED", "PrototypePowercoilRemoved", 1218704)

	self:Log("SPELL_AURA_APPLIED", "GroundDamage", 464854, 464248) -- Garbage Pile, Hot Garbage
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundDamage", 464854, 464248)
	self:Log("SPELL_PERIODIC_MISSED", "GroundDamage", 464854, 464248)
end

function mod:OnEngage()
	self:SetStage(1)

	electromagneticSortingCount = 1
	incineratorCount = 1
	demolishCount = 1
	meltdownCount = 1
	powercoilCount = 1

	mobCollector = {}
	mobMarks = {}

	self:Bar(464149, 11.1, CL.count:format(L.incinerator, incineratorCount)) -- Incinerator -- Fire
	self:Bar(464112, 17.7, CL.count:format(self:SpellName(464112), demolishCount)) -- Demolish
	self:Bar(464399, 22.2, CL.count:format(L.electromagnetic_sorting, electromagneticSortingCount)) -- Electromagnetic Sorting -- Balls + Adds
	self:Bar(1217954, 45.5, CL.count:format(self:SpellName(1217954), meltdownCount)) -- Meltdown
	self:Bar(467117, self:Mythic() and 66.7 or 100.0) -- Overdrive
	if self:Mythic() then
		self:Bar(1218704, 33.3, CL.count:format(self:SpellName(1218704), powercoilCount)) -- Prototype Powercoil
	end

	if self:GetOption(territorialBombshellMarker) then
		self:RegisterTargetEvents("AddMarking")
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AddMarking(_, unit, guid)
	if mobCollector[guid] and self:GetOption(territorialBombshellMarker) then
		self:CustomIcon(territorialBombshellMarker, unit, mobCollector[guid])
	end
end

function mod:ShortFuseApplied(args)
	for i = 8, 4, -1 do
		if not mobMarks[i] then
			mobCollector[args.destGUID] = i
			mobMarks[i] = args.destGUID
			return
		end
	end
end

function mod:ElectromagneticSorting(args)
	self:StopBar(CL.count:format(L.electromagnetic_sorting, electromagneticSortingCount))
	self:Message(args.spellId, "orange", CL.count:format(L.electromagnetic_sorting, electromagneticSortingCount))
	self:PlaySound(args.spellId, "long") -- damage and garbage over 5 seconds
	electromagneticSortingCount = electromagneticSortingCount + 1
	muffledDoomsplosionCount = 0
	local cd = electromagneticSortingCount == 3 and 72.2 or 51.1
	if self:Mythic() then
		cd = electromagneticSortingCount == 2 and 79.3 or 51.1
	end
	self:Bar(args.spellId, cd, CL.count:format(L.electromagnetic_sorting, electromagneticSortingCount))
end

function mod:SortedApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(461536) -- Rolling Rubbish
		self:PlaySound(461536, "warning") -- you're becoming rubbish
	end
end

do
	local ballSize = 0
	function mod:RollingRubbishApplied(args)
		if self:Me(args.destGUID) then
			ballSize = 0
			self:RegisterUnitEvent("UNIT_POWER_UPDATE", nil, "player", "vehicle")
		end
	end

	function mod:UNIT_POWER_UPDATE(_, unit, powerType)
		if powerType == "ALTERNATE" then
			local power = UnitPower(unit, 10)
			if power >= 200 and ballSize < 200 then
				self:Message(461536, "green", L.ball_size_large) -- Rolling Rubbish
				self:PlaySound(461536, "info")
			elseif power >= 100 and ballSize < 100 then
				self:Message(461536, "green", L.ball_size_medium) -- Rolling Rubbish
				self:PlaySound(461536, "alert")
			end
			ballSize = power
		end
	end

	function mod:RollingRubbishRemoved(args)
		if self:Me(args.destGUID) then
			self:PersonalMessage(461536, "removed")
			self:PlaySound(461536, "info")
			self:UnregisterUnitEvent("UNIT_POWER_UPDATE", "player", "vehicle")
		end
	end
end

function mod:GarbageDumpDamage(args)
	if self:MobId(args.destGUID) == 230322 and self:Me(args.sourceGUID) then -- Stix
		self:Message(465741, "green", L.garbage_dump_message:format(self:AbbreviateNumber(args.extraSpellId))) -- Garbage Dump
	end
end

function mod:RolledApplied(args)
	if self:Me(args.destGUID) then
		self:Message(465611, "red", L.rolled_on_you:format(self:ColorName(args.sourceName)))
		self:PlaySound(465611, "alarm")
	elseif self:Me(args.sourceGUID) then
		self:Message(465611, "red", L.rolled_from_you:format(self:ColorName(args.destName)))
		self:PlaySound(465611, "alarm")
	end
end

do
	local prev = 0
	function mod:DoomsplodedApplied(args)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "warning")
		end
	end
end
do
	local prev = 0
	function mod:MuffledDoomsplosionDamage(args)
		if args.time - prev > 0.2 then
			prev = args.time
			muffledDoomsplosionCount = muffledDoomsplosionCount + 1
			self:Message(args.spellId, "green", CL.count_amount:format(args.spellName, muffledDoomsplosionCount, self:GetStage()))
			-- self:PlaySound(args.spellId, "info")
		end
	end
end

function mod:ScrapRockets(args)
	local canDo, ready = self:Interrupter(args.sourceGUID)
	if canDo and ready then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:InfectedBiteApplied(args)
	if self:Me(args.destGUID) then
		local amount = args.amount or 1
		if amount % 2 == 1 then
			self:StackMessage(args.spellId, "blue", args.destName, amount, 6)
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:Incinerator(args)
	self:StopBar(CL.count:format(L.incinerator, incineratorCount))
	self:Message(args.spellId, "yellow", CL.count:format(L.incinerator, incineratorCount))
	self:PlaySound(args.spellId, "alert") -- debuffs
	incineratorCount = incineratorCount + 1
	local cd = incineratorCount == 5 and 46.7 or 25
	if self:Mythic() then
		cd = incineratorCount == 4 and 28.2 or 25.5
	end
	self:Bar(args.spellId, cd, CL.count:format(L.incinerator, incineratorCount))
end

function mod:IncinerationApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm") -- watch surrouding
	end
end

function mod:Demolish(args)
	self:StopBar(CL.count:format(args.spellName, demolishCount))
	self:Message(args.spellId, "purple", CL.count:format(args.spellName, demolishCount))
	self:PlaySound(args.spellId, "info")
	demolishCount = demolishCount + 1
	local cd = demolishCount == 3 and 72.2 or 51.5
	if self:Mythic() then
		cd = demolishCount == 2 and 79.3 or 51.1
	end
	self:Bar(args.spellId, cd, CL.count:format(args.spellName, demolishCount)) -- Delayed once due to overdrive?
end

function mod:DemolishApplied(args)
	local amount = args.amount or 1
	self:StackMessage(args.spellId, "purple", args.destName, amount, 3)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm") -- On you
	elseif self:Tank() and amount > 2 then
		self:PlaySound(args.spellId, "warning") -- tauntswap
	end
end

function mod:Meltdown(args)
	self:StopBar(CL.count:format(args.spellName, meltdownCount))
	self:TargetMessage(args.spellId, "purple", args.destName, CL.count:format(args.spellName, meltdownCount))
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm") -- On you
	else
		self:PlaySound(args.spellId, "alert") -- healer
	end
	meltdownCount = meltdownCount + 1
	local cd = meltdownCount == 3 and 72.2 or 51.5
	if self:Mythic() then
		cd = meltdownCount == 2 and 79.4 or 51.1
	end
	self:Bar(args.spellId, cd, CL.count:format(args.spellName, meltdownCount)) -- Delayed once due to overdrive?
end

function mod:Overdrive(args)
	self:StopBar(args.spellId)
	self:SetStage(2)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long") -- flying away
	-- self:Bar(467109, 13.25, L.landing) -- Trash Compactor // 12.5~14s

	-- XXX maybe make the gap bar time to overdrive + cd then just pause here? (ala broodtwister)
end

function mod:TrashCompactor(args)
	self:Message(467135, "red")
	self:PlaySound(467135, "warning") -- watch drop location
	self:CastBar(467135, 3.75)
end

function mod:MarkedForRecyclingApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "blue")
		-- self:PlaySound(args.spellId, "info") -- should be saved
		-- self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:MarkedForRecyclingRemoved(args)
	-- if self:Me(args.destGUID) then
	-- 	self:StopBar(args.spellId, args.destName)
	-- end
end

do
	local prev = 0
	function mod:PrototypePowercoilApplied(args)
		if args.time - prev > 1 then
			prev = args.time
			self:StopBar(CL.count:format(args.spellName, powercoilCount))
			self:Message(args.spellId, "cyan", CL.count:format(args.spellName, powercoilCount))
			powercoilCount = powercoilCount + 1
			self:Bar(args.spellId, powercoilCount == 2 and 69.6 or 51.5, CL.count:format(args.spellName, powercoilCount))
		end
		if self:Me(args.destGUID) then
			self:PersonalMessage(args.spellId)
			self:PlaySound(args.spellId, "alarm")
			self:TargetBar(args.spellId, 10, args.destName)
		end
	end

	function mod:PrototypePowercoilRemoved(args)
		if self:Me(args.destGUID) then
			self:StopBar(args.spellId, args.destName)
		end
	end
end

do
	local prev = 0
	function mod:GroundDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 2 then
			prev = args.time
			self:PlaySound(args.spellId, "underyou")
			self:PersonalMessage(args.spellId, "underyou")
		end
	end
end
