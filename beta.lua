local Iris = loadstring(game:HttpGet("https://raw.githubusercontent.com/x0581/Iris-Exploit-Bundle/main/bundle.lua"))().Init(game.CoreGui)
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Workspace = game.Workspace
local BatRemotes = ReplicatedStorage:WaitforChild("BatRemotes")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

local function batmechanics()
    local bat = Character:FindFirstChildWhichIsA("Tool") or LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
    local hit = bat and BatRemotes and BatRemotes:FindFirstChild(bat.Name)
    local special = hit and hit:FindFirstChildWhichIsA("RemoteEvent")

    return bat, hit, special 
end


local BatGUI = {
    ["Kill Aura"] = {
        ["Value"] = Iris.State(false),
        ["Function"] = pcall(function()
            
        end),
    },
    ["Kill All"] = {
        ["Value"] = Iris.State(false),
        ["Function"] = pcall(function()
            -- CODE
        end),
    },
    ["No Cooldown"] = {
        ["Value"] = Iris.State(false),
        ["Function"] = pcall(function()
            -- CODE
        end),
    },
    ["Lag Server"] = {
        ["Value"] = Iris.State(false),
        ["Function"] = pcall(function()
            -- CODE
        end),
    },
}

-- lazy will do later