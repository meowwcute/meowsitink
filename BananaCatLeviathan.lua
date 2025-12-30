-- [[ BANANA CAT HUB - LEVIATHAN PREMIUM KAITUN ]]
-- Script Name: Banana Cat Hub Leviathan
-- Credits: by meow
-- Note: Fixed Scroll for Mobile

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Banana Cat Hub Leviathan",
    SubSubtitle = "by meow", --
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 360), -- Kích thước gọn cho điện thoại
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.End
})

-- [[ TOGGLE UI BANANA CAT ]]
local ScreenGui = game:GetService("CoreGui"):FindFirstChild("BananaCatToggle") or Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "BananaCatToggle"
local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Size = UDim2.fromOffset(40, 40)
ToggleButton.Image = "rbxassetid://127470963031421"
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.4
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 8)
ToggleButton.MouseButton1Click:Connect(function() Window:Minimize() end)

-- [[ KHAI BÁO TABS VỚI TÍNH NĂNG CUỘN (SCROLL) ]]
local Tabs = {
    Setup = Window:AddTab({ Title = "Tab Setup Hunt Leviathan", Icon = "settings" }), --
    Settings = Window:AddTab({ Title = "Setting Hold and Select Skill", Icon = "zap" }), --
    DevilFruit = Window:AddTab({ Title = "Tab Devil Fruit", Icon = "apple" }), --
    Webhook = Window:AddTab({ Title = "Tab Webhook", Icon = "message-square" }) --
}

-- Bật tính năng vuốt trượt cho Mobile
for _, tab in pairs(Tabs) do
    tab:Select() -- Kích hoạt trạng thái để áp dụng scroll
end

local Options = Fluent.Options
local lp = game.Players.LocalPlayer
local TS = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")

-- [[ LOGIC KAITUN: NỘP TIM VÀ MUA THUYỀN MỚI ]]
local function AutoRestartLoop()
    local myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")
    if myBoat then
        -- Lái về bến Tiki nộp tim
        local seat = myBoat.VehicleSeat
        local drive = TS:Create(seat, TweenInfo.new(80, Enum.EasingStyle.Linear), {CFrame = CFrame.new(-2500, 20, 1000)})
        drive:Play()
        drive.Completed:Wait()
        
        task.wait(5)
        lp.Character.Humanoid.Health = 0 -- Reset để quay lại Tiki mua thuyền tiếp
        task.wait(5)
    end
end

-- [[ GIAO DIỆN SETUP - BÂY GIỜ ĐÃ CÓ THỂ VUỐT XUỐNG ]]
do
    Tabs.Setup:AddSection("NPC Spy Status")
    Tabs.Setup:AddParagraph({ Title = "Status SPY", Content = "You can find leviathan now" }) --
    
    Tabs.Setup:AddToggle("NoFrog", {Title = "No Frog", Default = false}) --
    Tabs.Setup:AddToggle("BoostFps", {Title = "Boost Fps", Default = false}) --
    
    Tabs.Setup:AddToggle("AccBuyBoat", {Title = "Account Buy Boat (Tiki)", Default = false}) --
    Tabs.Setup:AddToggle("StartHunt", {Title = "Start Hunt Leviathan", Default = false}) --
    
    -- Thêm các chức năng phía dưới để bạn kiểm tra tính năng cuộn
    Tabs.Setup:AddToggle("AutoCraft", {Title = "Auto Craft Scroll", Default = false}) --
    Tabs.Setup:AddToggle("AutoAnchor", {Title = "Auto Anchor Boat at Sea 6", Default = false})
end

-- [[ LOGIC THỰC THI ]]
task.spawn(function()
    while task.wait(1) do
        if Options.StartHunt and Options.StartHunt.Value then
            local myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")
            if Options.AccBuyBoat.Value and not myBoat then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "BeastHunter")
                task.wait(2)
            end
            if workspace:FindFirstChild("LeviathanHeart") then
                AutoRestartLoop()
            end
        end
    end
end)

SaveManager:SetLibrary(Fluent)
SaveManager:SetFolder("BananaCatKaitun")
Window:SelectTab(1)
                    VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    task.wait(2)
                    VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    AutoRestartLoop()
                end
            end
        end
    end
end)

SaveManager:SetLibrary(Fluent)
SaveManager:SetFolder("BananaCatLevi")
Window:SelectTab(1)

