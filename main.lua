-- Variables
local Iris = loadstring(game:HttpGet("https://raw.githubusercontent.com/x0581/Iris-Exploit-Bundle/main/bundle.lua"))().Init(game.CoreGui)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BatRemotes = ReplicatedStorage:FindFirstChild("BatRemotes")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
end)

local UltSpam = Iris.State(false)
local KillAura = Iris.State(false)
local NoCooldown = Iris.State(false)
local KillAll = Iris.State(false)
local LagServer = Iris.State(false)

local victim = Iris.State("") -- meant to be blank!
local v_toggle = Iris.State(false)

-- Core
local function mech()
    local one = Character:FindFirstChildWhichIsA("Tool") or LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
    local two = one and BatRemotes and BatRemotes:FindFirstChild(one.Name)
    local three = two and two:FindFirstChildWhichIsA("RemoteEvent")
    return one, two, three 
end

RunService.Heartbeat:Connect(function()
    if not KillAura.value and not UltSpam.value and not NoCooldown.value and not KillAll.value and not LagServer.value and not victim.value and not v_toggle then return end
    local bat, hit, special = mech()

    if KillAura.value and hit then hit:FireServer(bat) end
    if UltSpam.value and special then special:FireServer(bat) end

	if NoCooldown.value and bat then
		bat:SetAttribute("cooldown", 0)
		bat:SetAttribute("ability_cooldown", 0)
	end

    if KillAll.value and bat then
        for _, v in ipairs(Players:GetPlayers()) do
            local char = v.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if char and hrp then
                local Event = BatRemotes["Electro Bat"].Electrify
                Event:FireServer(
                    bat,
                    hrp.Position
                )
            end
        end
    end

    if LagServer.value then
        --[[

            Will Work on Later!

        ]]--
    end

    if victim.value and v_toggle.value then
        local person = Players:FindFirstChild(victim.Value)
        if person then
            local char = person.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if char and hrp then
                local Event = BatRemotes["Electro Bat"].Electrify
                Event:FireServer(
                    bat,
                    hrp.Position
                )
            end
        end
    end
end)

-- UI
Iris:Connect(function()
    Iris.Window({"Bat Game UI"})
        Iris.Text({"Script by @solla15"})
        Iris.SameLine()
            Iris.Checkbox({"Kill Aura"}, {isChecked = KillAura})
            Iris.Checkbox({"Spam Ability"}, {isChecked = UltSpam})
            Iris.Checkbox({"No Cooldowns"}, {isChecked = NoCooldown})
            Iris.Checkbox({"Kill All"}, {isChecked = KillAll})
        Iris.End()
        Iris.SameLine()
            Iris.InputText({"Kill Player"}, {text = victim})
            Iris.Checkbox({"Toggle"}, {isChecked = v_toggle})
        Iris.End()

        Iris.Separator()

        Iris.Checkbox({"Lag Server"}, {isChecked = LagServer})
        if Iris.Button({"Infinite Yield"}).clicked then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    Iris.End()
end)