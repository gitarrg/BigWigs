local L = BigWigs:NewBossLocale("Gnarlroot", "deDE")
if not L then return end
if L then
	L.shadowflame_cleave = "Frontaler Kegel"
	L.tortured_scream = "Schrei"
end

L = BigWigs:NewBossLocale("Igira the Cruel", "deDE")
if L then
	L.blistering_spear = "Speere"
	L.blistering_spear_single = "Speer"
	L.blistering_torment = "Kette"
	L.twisting_blade = "Klingen"
	L.marked_for_torment = "Qualen"
	L.umbral_destruction = "Soak"
	L.heart_stopper = "Heilungen absorbiert"
	L.heart_stopper_single = "Heilung absorbiert"
end

L = BigWigs:NewBossLocale("Volcoross", "deDE")
if L then
	L.custom_off_all_scorchtail_crash = "Alle Zauber anzeigen"
	L.custom_off_all_scorchtail_crash_desc = "Zeigt Timer und Nachrichten für alle Zauber von Sengschweifsturz an, statt nur die Zauber auf Deiner Seite."

	L.flood_of_the_firelands = "Soaks"
	L.flood_of_the_firelands_single_wait = "Warten" -- Wait 3, Wait 2, Wait 1 countdown before soak debuff is applied
	L.flood_of_the_firelands_single = "Soak"
	L.scorchtail_crash = "Schweifschlag"
	L.serpents_fury = "Flammen"
	L.coiling_flames_single = "Flamme"
end

L = BigWigs:NewBossLocale("Council of Dreams", "deDE")
if L then
	L.agonizing_claws_debuff = "{421022} (Debuff)"

	L.ultimate_boss = "Ultimate (%s)"
	L.special_bar = "Ult [%s] (%d)"
	L.special_mythic_bar = "Ult [%s/%s] (%d)"
	L.special_mechanic_bar = "%s [Ult] (%d)"

	L.barreling_charge = "Ansturm"
	L.poisonous_javelin = "Wurfspeer"
	L.song_of_the_dragon = "Lied"
	L.polymorph_bomb = "Enten"
	L.polymorph_bomb_single = "Ente"
end

L = BigWigs:NewBossLocale("Larodar, Keeper of the Flame", "deDE")
if L then
	L.custom_on_repeating_yell_smoldering_suffocation = "Ersticken Gesundheit wiederholen"
	L.custom_on_repeating_yell_smoldering_suffocation_desc = "Gibt wiederholt Chatnachrichten für Qualmendes Ersticken aus um mitzuteilen, dass unter 75% Gesundheit erreicht sind."

	L.blazing_coalescence_on_player_note = "Wenn es auf Dir ist"
	L.blazing_coalescence_on_boss_note = "Wenn es auf dem Boss ist"

	L.scorching_roots = "Wurzeln"
	L.furious_charge = "Ansturm"
	L.blazing_thorns = "Ausweichen"
	L.falling_embers = "Soaks"
	L.smoldering_backdraft = "Frontal"
	L.fire_whirl = "Wirbel"
end

L = BigWigs:NewBossLocale("Nymue, Weaver of the Cycle", "deDE")
if L then
	L.mythic_add_death = "%s getötet"

	L.continuum = "Neue Fäden"
	L.surging_growth = "Neue Soaks"
	L.ephemeral_flora = "Roter Soak"
	L.viridian_rain = "Schaden + Bomben"
	L.lumbering_slam = "Frontaler Kegel"
	L.threads = "Fäden" -- From the spell description of Impending Loom (429615) "threads of energy"
end

L = BigWigs:NewBossLocale("Smolderon", "deDE")
if L then
	L.brand_of_damnation = "Tank Soak"
	L.lava_geysers = "Geysire"
	L.flame_waves = "Wirbel"
end

L = BigWigs:NewBossLocale("Tindral Sageswift, Seer of the Flame", "deDE")
if L then

	L.seed_soaked = "Samen gesoaked"
	L.all_seeds_soaked = "Samen fertig!"

	L.blazing_mushroom = "Pilze"
	L.fiery_growth = "Dispels"
	L.mass_entanglement = "Wurzeln"
	L.incarnation_moonkin = "Mondkingestalt"
	L.incarnation_tree_of_flame = "Treantgestalt"
	L.flaming_germination = "Samen"
	L.suppressive_ember = "Heilungen absorbiert"
	L.suppressive_ember_single = "Heilung absorbiert"
	L.flare_bomb = "Federn"
end

L = BigWigs:NewBossLocale("Fyrakk the Blazing", "deDE")
if L then
	L.spirit_trigger = "Geist der Kaldorei"

	L.fyralaths_bite = "Frontal"
	L.fyralaths_bite_mythic = "Frontals"
	L.fyralaths_mark = "Mal"
	L.darkflame_shades = "Schemen"
	L.darkflame_cleave = "Mythische Soaks"

	L.incarnate_intermission = "Zurückstoßen"
	--L.corrupt_removed = "Corrupt Over (%.1fs remaining)" -- eg: Corrupt Over (5.0s remaining)

	L.incarnate = "Abheben"
	L.spirits_of_the_kaldorei = "Geister"
	L.molten_gauntlet = "Fäuste"
	--L.mythic_debuffs = "Cages" -- Shadow Cage & Molten Eruption

	L.greater_firestorm_shortened_bar = "Feuersturm [G]" -- G for Greater
	L.greater_firestorm_message_full = "Feuersturm [Groß]"
	L.eternal_firestorm_shortened_bar = "Feuersturm [E]" -- E for Eternal
	L.eternal_firestorm_message_full = "Feuersturm [Ewig]"

	-- L.eternal_firestorm_swirl = "Eternal Firestorm Swirls"
	-- L.eternal_firestorm_swirl_desc = "Timers for Eternal Firestorm Swirls."
	-- L.eternal_firestorm_swirl_bartext = "Swirls"
end
