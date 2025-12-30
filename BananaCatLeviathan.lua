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
    Size = UDim2.fromOffset(500, 380), -- Đã thu nhỏ từ 580x480 xuống 500x380 để không bị quá to
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.End
})

-- [[ TOGGLE UI BANANA CAT NHỎ GỌN ]]
local ScreenGui = game:GetService("CoreGui"):FindFirstChild("BananaCatToggle") or Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "BananaCatToggle"

local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Position = UDim2.new(0, 10, 0, 10) -- Căn lề sát góc hơn một chút
ToggleButton.Size = UDim2.fromOffset(40, 40) -- Thu nhỏ nút từ 45x45 xuống 40x40
ToggleButton.Image = "rbxassetid://127470963031421"
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.BackgroundTransparency = 0.4
local UICorner = Instance.new("UICorner", ToggleButton)
UICorner.CornerRadius = UDim.new(0, 8) -- Bo tròn nhỏ hơn cho hợp kích thước mới
ToggleButton.MouseButton1Click:Connect(function() Window:Minimize() end)

-- [[ TABS - GIỮ NGUYÊN DANH MỤC THEO VIDEO ]]
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

-- [[ LOGIC KAITUN: NỘP TIM VÀ RESET MUA THUYỀN MỚI ]]
local function AutoRestartLoop()
    local myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")
    if myBoat then
        -- Lái thuyền kéo tim về Tiki
        local seat = myBoat.VehicleSeat
        local drive = TS:Create(seat, TweenInfo.new(80, Enum.EasingStyle.Linear), {CFrame = CFrame.new(-2500, 20, 1000)})
        drive:Play()
        drive.Completed:Wait()
        
        task.wait(5) -- Đợi nộp tim hoàn tất
        lp.Character.Humanoid.Health = 0 -- Reset để bắt đầu chu kỳ mua thuyền mới tại Tiki
        task.wait(5)
    end
end

-- [[ GIAO DIỆN SETUP - THIẾT KẾ GỌN GÀNG ]]
do
    Tabs.Setup:AddSection("NPC Spy Status")
    local SpyLabel = Tabs.Setup:AddParagraph({ Title = "Status SPY", Content = "You can find leviathan now" }) --
    
    Tabs.Setup:AddToggle("NoFrog", {Title = "No Frog", Default = false}) --
    Tabs.Setup:AddToggle("BoostFps", {Title = "Boost Fps", Default = false}) --
    
    Tabs.Setup:AddToggle("AccBuyBoat", {Title = "Account Buy Boat (Tiki)", Default = false}) --
    Tabs.Setup:AddToggle("StartHunt", {Title = "Start Hunt Leviathan", Default = false}) --
end

-- [[ LOGIC CHIẾN ĐẤU & KAITUN ]]
task.spawn(function()
    while task.wait(1) do
        if Options.StartHunt and Options.StartHunt.Value then
            local myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")

            -- Mua thuyền tại Tiki Outpost
            if Options.AccBuyBoat.Value and not myBoat then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "BeastHunter")
                end)
                task.wait(2)
                myBoat = workspace.Boats:FindFirstChild(lp.Name .. "Boat")
            end

            -- Nếu có tim, thực hiện kéo về và lặp lại thao tác mua thuyền mới
            if workspace:FindFirstChild("LeviathanHeart") then
                local Harpoon = myBoat and myBoat:FindFirstChild("HarpoonSeat", true)
                if Harpoon then
                    -- Bắn móc kéo tim
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

