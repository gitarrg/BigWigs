local L = BigWigs:NewBossLocale("Atramedes", "koKR")
if L then
	L.ground_phase = "지상 단계"
	L.ground_phase_desc = "아트라메데스의 착지를 알립니다."
	L.air_phase = "공중 단계"
	L.air_phase_desc = "아트라메데스의 이륙을 알립니다."

	L.air_phase_trigger = "그래"	--check

	L.sonicbreath_cooldown = "~음파 숨결"
end

L = BigWigs:NewBossLocale("Chimaeron", "koKR")
if L then
	L.bileotron_engage = "The Bile-O-Tron springs to life and begins to emit a foul smelling substance."	--check
	--L.engage = "Engage"	--what?
	L.next_system_failure = "다음 시스템 오류"
	L.break_message = "깨부수기 %2$dx : %1$s"

	L.warmup = "전투 준비"
	L.warmup_desc = "전투가 시작되기까지의 시간입니다."
end

L = BigWigs:NewBossLocale("Magmaw", "koKR")
if L then
	
end

L = BigWigs:NewBossLocale("Maloriak", "koKR")
if L then
	L.final_phase = "마지막 단계"

	L.release_aberration_message = "%s 주위 - 돌연변이!"
	L.release_all = "%s 주위 - 모든 실험체!"

	L.bitingchill_say = "나에게 살을 에는 추위!"

	L.flashfreeze = "~순간 빙결"
	L.consuming_flames = "당신은 이글거리는 불꽃!"

	L.phase = "단계"
	L.phase_desc = "단계 변화를 알립니다."
	L.next_phase = "다음 단계"

	L.red_phase_trigger = "섞고 흔들어서, 열을 가한다..."
	L.red_phase = "|cFFFF0000붉은|r 단계"
	L.blue_phase_trigger = "급격한 온도 변화에 필멸의 육신"
	L.blue_phase = "|cFF809FFE푸른|r 단계"
	L.green_phase_trigger = "이건 좀 불안정하지만"
	L.green_phase = "|cFF33FF00초록|r 단계"
end

L = BigWigs:NewBossLocale("Nefarian", "koKR")
if L then
	L.phase = "단계"
	L.phase_desc = "단계 변화를 알립니다."

	L.phase_x = "%d 단계!"

	L.phase_two_trigger = "저주받을 필멸자"	--check

	L.chromatic_prototype = "Chromatic Prototype" -- 3 adds name
end

L = BigWigs:NewBossLocale("Omnitron Defense System", "koKR")
if L then
	L.acquiring_target = "대상 획득"
	L.chemical_cloud_message = "당신은 화학 구름!"
end
