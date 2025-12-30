-- [[ BANANA CAT HUB - LEVIATHAN PREMIUM KAITUN ]]
-- Script Name: Banana Cat Hub Leviathan
-- Credits: by meow

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Banana Cat Hub Leviathan",
    SubSubtitle = "by meow", --
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 480),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.End
})

-- [[ TOGGLE UI BANANA CAT CHUẨN GÓC TRÁI ]]
local ScreenGui = game:GetService("CoreGui"):FindFirstChild("BananaCatToggle") or Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "BananaCatToggle"

local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Position = UDim2.new(0, 15, 0, 15) -- Dưới logo Roblox
ToggleButton.Size = UDim2.fromOffset(45, 45)
ToggleButton.Image = "rbxassetid://127470963031421"
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.4
local UICorner = Instance.new("UICorner", ToggleButton)
UICorner.CornerRadius = UDim.new(0, 10)
ToggleButton.MouseButton1Click:Connect(function() Window:Minimize() end)

-- [[ KHAI BÁO TABS THEO VIDEO ]]
local Tabs = {
    Setup = Window:AddTab({ Title = "Tab Setup Hunt Leviathan", Icon = "settings" }), --
    Settings = Window:AddTab({ Title = "Setting Hold and Select Skill", Icon = "zap" }), --
    DevilFruit = Window:AddTab({ Title = "Tab Devil Fruit", Icon = "apple" }), --
    Webhook = Window:AddTab({ Title = "Tab Webhook", Icon = "message-square" }) --
}

local Options = Fluent.Options
local lp = game.Players.LocalPlayer
local TS = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")

-- [[ TỌA ĐỘ CHUẨN TIKI ]]
local TIKI_NPC = CFrame.new(-2021, 15, 1201)
local TIKI_PORT = CFrame.new(-2500, 20, 1000)

-- [[ HÀM BAY TWEEN SIÊU TỐC ]]
function Tween(targetCFrame)
    if not targetCFrame then return end
    local char = lp.Character or lp.CharacterAdded:Wait()
    local dist = (targetCFrame.Position - char.HumanoidRootPart.Position).Magnitude
    local t = TS:Create(char.HumanoidRootPart, TweenInfo.new(dist/300, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    t:Play()
    return t
end

-- [[ LOGIC KAITUN: NỘP TIM VÀ MUA THUYỀN MỚI ]]
local function AutoRestartLoop()
    local myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")
    if myBoat then
        -- Lái thuyền kéo tim về bến Tiki
        local seat = myBoat.VehicleSeat
        local drive = TS:Create(seat, TweenInfo.new(80, Enum.EasingStyle.Linear), {CFrame = TIKI_PORT})
        drive:Play()
        drive.Completed:Wait()
        
        task.wait(5) -- Đợi tim nộp vào Tiki
        
        -- Reset để bắt đầu chu kỳ mới: Mua thuyền mới ngay lập tức
        lp.Character.Humanoid.Health = 0
        task.wait(5)
    end
end

-- [[ GIAO DIỆN SETUP ]]
do
    Tabs.Setup:AddSection("NPC Spy Status")
    local SpyLabel = Tabs.Setup:AddParagraph({ Title = "Status SPY", Content = "You can find leviathan now" }) --
    
    Tabs.Setup:AddToggle("NoFrog", {Title = "No Frog", Default = false}) --
    Tabs.Setup:AddToggle("BoostFps", {Title = "Boost Fps", Default = false}) --
    Tabs.Setup:AddButton({Title = "Teleport Third Sea", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end}) --

    Tabs.Setup:AddDropdown("SelectOwner", {Title = "Select Owner Boat", Values = {}, Multi = false}) --
    Tabs.Setup:AddToggle("AccBuyBoat", {Title = "Account Buy Boat", Default = false}) --
    Tabs.Setup:AddToggle("StartHunt", {Title = "Start Hunt Leviathan", Default = false}) --
end

-- [[ LOGIC CHIẾN ĐẤU: THÂN TRƯỚC -> ĐẦU/ĐUÔI SAU ]]
local function FightLeviathan()
    local Leviathan = workspace.Enemies:FindFirstChild("Leviathan")
    if Leviathan then
        for _, part in pairs(Leviathan:GetChildren()) do
            -- Ưu tiên đánh các đoạn thân (Segments) trước
            if part.Name:find("Segment") and part:FindFirstChild("Humanoid") and part.Humanoid.Health > 0 then
                while part.Parent and part.Humanoid.Health > 0 and Options.StartHunt.Value do
                    Tween(part.CFrame * CFrame.new(0, 30, 0))
                    -- Tự động sử dụng kỹ năng đã chọn trong Setting
                    task.wait(0.1)
                end
            end
        end
        -- Sau khi thân chết, đánh phần Đầu và Đuôi
    end
end

-- [[ VÒNG LẶP KAITUN CHÍNH ]]
task.spawn(function()
    while task.wait(1) do
        if Options.StartHunt and Options.StartHunt.Value then
            local char = lp.Character
            local myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")

            -- Bước 1: Bắt buộc mua thuyền Beast Hunter ở Tiki
            if Options.AccBuyBoat.Value and not myBoat then
                Tween(TIKI_NPC)
                task.wait(2)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "BeastHunter")
                task.wait(2)
                myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")
            end

            -- Bước 2: Bay thuyền tìm đảo (Logic fly ở 170)
            if myBoat and myBoat:FindFirstChild("VehicleSeat") then
                local seat = myBoat.VehicleSeat
                if seat.Occupant == char.Humanoid then
                    seat.Anchored = true
                    seat.CFrame = CFrame.new(seat.Position.X, 170, seat.Position.Z) * seat.CFrame.Rotation
                    
                    -- Bay thẳng tìm đảo
                    while Options.StartHunt.Value and seat.Occupant == char.Humanoid do
                        if workspace:FindFirstChild("Frozen Dimension", true) then
                            seat.Anchored = true
                            char.Humanoid.Jump = true
                            FightLeviathan()
                            break
                        end
                        seat.CFrame = seat.CFrame * CFrame.new(0, 0, 5)
                        task.wait()
                    end
                end
            end

            -- Bước 3: Kéo tim và Restart Loop
            if workspace:FindFirstChild("LeviathanHeart") then
                local Harpoon = myBoat:FindFirstChild("HarpoonSeat", true)
                if Harpoon then
                    Tween(Harpoon.CFrame)
                    task.wait(1)
                    VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0) -- Bắn móc
                    task.wait(2)
                    VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    AutoRestartLoop() -- Kéo về Tiki và mua thuyền mới
                end
            end
        end
    end
end)

SaveManager:SetLibrary(Fluent)
SaveManager:SetFolder("BananaCatLevi")
Window:SelectTab(1)
