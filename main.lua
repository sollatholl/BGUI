-- Variables
local Iris = loadstring(game:HttpGet("https://raw.githubusercontent.com/x0581/Iris-Exploit-Bundle/main/bundle.lua"))().Init(game.CoreGui)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BatRemotes = ReplicatedStorage:FindFirstChild("BatRemotes")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
end)

local UltSpam = Iris.State(false)
local KillAura = Iris.State(false)
local NoCD = Iris.State(false)
local KillAll = Iris.State(false)
local LAG = Iris.State(false)

-- Core
local function mech()
    local one = Character:FindFirstChildWhichIsA("Tool") or LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")

    local two
    if one and BatRemotes then
        two = BatRemotes:FindFirstChild(one.Name)
    end

    local three
    if two and two:FindFirstChildWhichIsA("RemoteEvent") then
        three = two:FindFirstChildWhichIsA("RemoteEvent")
    end

    if one and two and three then
        return one, two, three
    else
        return error("Something went wrong with grabbing.")
    end
end

local function players()
    local plrs = {}
    for _, p in ipairs(Players:GetPlayers()) do
        table.insert(plrs, p)
    end

    return plrs
end

RunService.Heartbeat:Connect(function()
    if not KillAura.value and not UltSpam.value and not NoCD.value and not KillAll.value and not LAG.value then return end
    local bat, hit, special = mech()

    if KillAura.value and hit then hit:FireServer(bat) end
    if UltSpam.value and special then special:FireServer(bat) end
	if NoCD.value then
		bat:SetAttribute("cooldown", 0)
		bat:SetAttribute("ability_cooldown", 0)
	end
    if KillAll.vale then
        local ppl = players()
        for _, v in ipairs(ppl) do
            local char = v.Character or v.CharacterAdded:wait()
            local hrp = char and v:FindFirstChild("HumanoidRootPart")

            local Event = BatRemotes["Electro Bat"].Electrify
            Event:FireServer(
                bat, -- game:GetService("Players").LocalPlayer.Character["Electro Bat"]
                hrp.Position
            )
        end
    end
    if LAG.value then
        -- will finish later once i find those remotes.
    end
end)

-- UI
Iris:Connect(function()
    Iris.Window({"Bat Game UI"}, {NoBackground = true}) do
		Iris.Text({"Script by @z3zta"})
		Iris.Checkbox({"Kill Aura"}, {isChecked = KillAura})
		Iris.Checkbox({"Spam Ability"}, {isChecked = UltSpam})
		Iris.Checkbox({"No Cooldowns"}, {isChecked = NoCD})
        Iris.Checkbox({"Kill All"}, {isChecked = KillAll})
        Iris.Checkbox({"Lag Server"}, {isChecked = LAG})
        Iris.End()
    end
end)
