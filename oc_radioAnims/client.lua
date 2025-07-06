--animation: https://www.gta5-mods.com/misc/leo-custom-anim
local internalData = {
    [1] = { dict = "random@arrests", anim = "generic_radio_enter" },
    [2] = { dict = "anim@cop_mic_pose_002", anim = "chest_mic" },
    [3] = { dict = "cellphone@", anim = "cellphone_call_listen_base" }
}
LATESTANIM = 0
CreateThread(function()
    while not ESX.PlayerData or not ESX.PlayerData.identifier do
        Wait(0)
    end
    local kvpValue = GetResourceKvpInt('radioAnim' .. ESX.PlayerData.identifier)
    LATESTANIM = tonumber(kvpValue)
    if not LATESTANIM or not internalData[LATESTANIM] then
        LATESTANIM = 1
    end
    exports["pma-voice"]:setRadioTalkAnim(
        internalData[LATESTANIM].dict,
        internalData[LATESTANIM].anim
    )
end)

lib.registerContext({
    id = 'menu_radioAnimations',
    title = 'Válassz az alábbi rádió animációk közül',
    options = {
        {
            title = 'rádió anim',
            description = 'Ezzel az anímáció felhasználásával az eredetire állítod vissza.',
            icon = '1',
            event = 'menu_radio_button_pressed',
            arrow = true,
            args = { type = 1 }
        },
        {
            title = 'rádió anim',
            description = 'Ezzel az anímáció felhasználásával a karakter a mellkasánál fog rádiózni.',
            icon = '2',
            event = 'menu_radio_button_pressed',
            arrow = true,
            args = { type = 2 }
        },
        {
            title = 'rádió anim',
            description = 'Ezzel az anímáció felhasználásával a karakter a fülénél fog rádiózni.',
            icon = '3',
            event = 'menu_radio_button_pressed',
            arrow = true,
            args = { type = 3 }
        }
    }
})

RegisterNetEvent('menu_radio_button_pressed', function(args)
    local selectedType = args.type
    if selectedType and internalData[selectedType] then
        SetResourceKvpInt('radioAnim' .. ESX.PlayerData.identifier, selectedType)
        exports["pma-voice"]:setRadioTalkAnim(
            internalData[selectedType].dict,
            internalData[selectedType].anim
        )
        LATESTANIM = selectedType
    end
end)

RegisterCommand('openRadioPanel', function()
    lib.showContext('menu_radioAnimations')
end, false)

RegisterKeyMapping('openRadioPanel', 'Rádió panel', "keyboard", "f1")

AddEventHandler('esx:onPlayerDeath', function(data)
    if data then
        lib.hideContext(true)
    end
end)
