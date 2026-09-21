local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local THEME = {
    Background = Color3.fromRGB(18, 18, 24),
    Container = Color3.fromRGB(28, 28, 36),
    Button = Color3.fromRGB(38, 38, 50),
    Accent = Color3.fromRGB(0, 210, 255),
    Text = Color3.fromRGB(240, 240, 245),
    TextSub = Color3.fromRGB(160, 160, 175),
    ToggleOn = Color3.fromRGB(80, 220, 120),
    ToggleOff = Color3.fromRGB(255, 85, 85),
    CloseBtn = Color3.fromRGB(235, 60, 80)
}

local corner = Instance.new("UICorner")
corner.Name="UICorner"
corner.CornerRadius = UDim.new(0, radius or 6)

local function addCorner(parent, radius)
    if not parent then return end
    local var = parent:FindFirstChild("UICorner")
    if var then var:Destroy() end
    local corner1 = corner:Clone()
    corner1.Parent = parent
    return corner1
end

-- Tạo ScreenGUI
local MenuGUI = Instance.new("ScreenGui")
MenuGUI.Name = "MenuGUI"
MenuGUI.DisplayOrder = 10
MenuGUI.IgnoreGuiInset = true
MenuGUI.ResetOnSpawn = false
MenuGUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Icon Mở Menu
local frameIcon = Instance.new("Frame")
frameIcon.Name = "frameIcon"
frameIcon.Size = UDim2.new(0, 35, 0, 35)
frameIcon.Position = UDim2.new(0.05, 0, 0.2, 0)
frameIcon.BackgroundColor3 = THEME.Container
frameIcon.BorderSizePixel = 0
frameIcon.Parent = MenuGUI
addCorner(frameIcon, 10)

local Icon = Instance.new("ImageButton")
Icon.Name = "Icon"
Icon.Size = UDim2.new(1, 0, 1, 0)
Icon.BackgroundColor3 = THEME.Accent
Icon.BackgroundTransparency = 0.8
Icon.BorderSizePixel = 0
Icon.Parent = frameIcon
addCorner(Icon, 10)

local frame = Instance.new("Frame")
frame.Name = "frame"
frame.Size = UDim2.new(0, 520, 0, 340)
frame.Position = UDim2.new(0.15, 0, 0.15, 0)
frame.BackgroundColor3 = THEME.Background
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = MenuGUI
addCorner(frame, 10)

local Title = Instance.new("TextButton")
Title.Name = "Title"
Title.Text = "  nho nhặc Hub  |  make by: Next :>"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = THEME.Accent
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = THEME.Container
Title.BorderSizePixel = 0
Title.AutoButtonColor = false
Title.Parent = frame
addCorner(Title,10)

-- Nút Đóng (Close)
local closeButton = Instance.new("TextButton")
closeButton.Name = "closeButton"
closeButton.Text = "x"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.TextColor3 = THEME.Text
closeButton.Size = UDim2.new(0, 35, 1, 0)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = THEME.CloseBtn
closeButton.BorderSizePixel = 0
closeButton.Parent = Title
addCorner(closeButton, 8)

-- Thanh Cuộn Danh Mục Bên Trái (Left Navigation)
local MenuScrolling = Instance.new("ScrollingFrame")
MenuScrolling.Name = "MenuScrolling"
MenuScrolling.Size = UDim2.new(0, 130, 1, -45)
MenuScrolling.Position = UDim2.new(0, 8, 0, 40)
MenuScrolling.BackgroundColor3 = THEME.Container
MenuScrolling.BorderSizePixel = 0
MenuScrolling.ScrollBarThickness = 2
MenuScrolling.ScrollBarImageColor3 = THEME.Accent
MenuScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
MenuScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
MenuScrolling.Parent = frame
addCorner(MenuScrolling, 8)

local LeftListLayout = Instance.new("UIListLayout")
LeftListLayout.Name="LeftListLayout"
LeftListLayout.Padding = UDim.new(0, 4)
LeftListLayout.SortOrder = Enum.SortOrder.LayoutOrder
LeftListLayout.Parent = MenuScrolling

local LeftPadding = Instance.new("UIPadding")
LeftPadding.Name="LeftPadding"
LeftPadding.PaddingTop = UDim.new(0, 4)
LeftPadding.PaddingBottom = UDim.new(0, 4)
LeftPadding.PaddingLeft = UDim.new(0, 4)
LeftPadding.PaddingRight = UDim.new(0, 4)
LeftPadding.Parent = MenuScrolling

-- Template Nút Bấm
local textButton = Instance.new("TextButton")
textButton.Name="textButton"
textButton.Font = Enum.Font.GothamMedium
textButton.TextSize = 13
textButton.TextColor3 = THEME.Text
textButton.BackgroundColor3 = THEME.Button
textButton.BorderSizePixel = 0
addCorner(textButton, 6)

-- Template Khung Nội Dung Bên Phải (Right Content Frame)
local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Name = "Scrolling"
Scrolling.Size = UDim2.new(1, -154, 1, -45)
Scrolling.Position = UDim2.new(0, 146, 0, 40)
Scrolling.BackgroundColor3 = THEME.Container
Scrolling.BorderSizePixel = 0
Scrolling.ScrollBarThickness = 3
Scrolling.ScrollBarImageColor3 = THEME.Accent
Scrolling.Visible = false
Scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
addCorner(Scrolling, 8)

local RightListLayout = Instance.new("UIListLayout")
RightListLayout.Name="RightListLayout"
RightListLayout.Padding = UDim.new(0, 6)
RightListLayout.SortOrder = Enum.SortOrder.LayoutOrder
RightListLayout.Parent = Scrolling

local RightPadding = Instance.new("UIPadding")
RightPadding.Name="RightPadding"
RightPadding.PaddingTop = UDim.new(0, 6)
RightPadding.PaddingBottom = UDim.new(0, 6)
RightPadding.PaddingLeft = UDim.new(0, 6)
RightPadding.PaddingRight = UDim.new(0, 6)
RightPadding.Parent = Scrolling

RightListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, RightListLayout.AbsoluteContentSize.Y + 12)
end)

-- Template TextBox
local textTextBox = Instance.new("TextBox")
textTextBox.Name="textTextBox"
textTextBox.Font = Enum.Font.Gotham
textTextBox.TextSize = 13
textTextBox.TextColor3 = THEME.Accent
textTextBox.BackgroundColor3 = THEME.Button
textTextBox.BorderSizePixel = 0
textTextBox.PlaceholderColor3 = THEME.TextSub
textTextBox.ClearTextOnFocus = false
addCorner(textTextBox, 6)

local FrameTop = Instance.new("Frame")
FrameTop.Name="FrameTop"
FrameTop.BackgroundColor3 = THEME.Container
FrameTop.BorderSizePixel = 0
addCorner(FrameTop, 6)

local TextLabelTop = Instance.new("TextLabel")
TextLabelTop.Name="TextLabelTop"
TextLabelTop.Font = Enum.Font.GothamBold
TextLabelTop.TextSize = 12
TextLabelTop.TextColor3 = THEME.Accent
TextLabelTop.BackgroundColor3 = THEME.Button
TextLabelTop.BackgroundTransparency = 1
TextLabelTop.TextXAlignment = Enum.TextXAlignment.Left
TextLabelTop.TextWrapped = true
addCorner(TextLabelTop, 6)

local FrameNotification = FrameTop:Clone()
FrameNotification.Name = "FrameNotification"
FrameNotification.Size = UDim2.new(0, 220, 0, 60)
FrameNotification.Position = UDim2.new(1, 10, 0, 20)
FrameNotification.Visible = false
addCorner(FrameNotification, 8)

local TitleNotification = TextLabelTop:Clone()
TitleNotification.Name="TitleNotification"
TitleNotification.Size = UDim2.new(1, -10, 0, 25)
TitleNotification.Position = UDim2.new(0, 10, 0, 0)
TitleNotification.Parent = FrameNotification

local MgsNotification = TextLabelTop:Clone()
MgsNotification.Name = "MgsNotification"
MgsNotification.Size = UDim2.new(1, -20, 0, 30)
MgsNotification.Position = UDim2.new(0, 10, 0, 25)
MgsNotification.Parent = FrameNotification

-- Notification Logic
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local function showNotification(title, message, duration)
    task.spawn(function()
        local Var = FrameNotification:Clone()
        Var.Parent = MenuGUI
        Var.TitleNotification.Text = title
        Var.MgsNotification.Text = message
        Var.Visible = true
        
        local tweenIn = TweenService:Create(Var, tweenInfo, {Position = UDim2.new(1, -230, 0, 20)})
        tweenIn:Play()
        tweenIn.Completed:Wait()
        
        task.wait(duration or 4)
        
        local tweenOut = TweenService:Create(Var, tweenInfo, {Position = UDim2.new(1, 10, 0, 20)})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        Var:Destroy()
    end)
end

-- Khóa/Mở Nút
local function LockButtonEnabled(button, enabled)
    button.Interactable = enabled
    button.Active = enabled
    button.AutoButtonColor = enabled

    if enabled then
        button.BackgroundColor3 = THEME.Button
        button.TextTransparency = 0
        button.BackgroundTransparency = 0
    else
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        button.TextTransparency = 0.5
        button.BackgroundTransparency = 0.2
    end
end

-- Thiết Kế Hệ Thống Nút & Tab
local ButtonTop = {}
ButtonTop.__index = ButtonTop

function ButtonTop.addButton(Name)
    local Child = {}
    Child.button = textButton:Clone()
    Child.button.Size=UDim2.new(1, 0, 0, 32)
    Child.button.Text = Name
    Child.button.Parent = MenuScrolling
    
    Child.Frame = Scrolling:Clone()
    Child.Frame.Parent = frame
    
    Child.button.MouseButton1Click:Connect(function()
        for _, i in ipairs(frame:GetChildren()) do
            if i:IsA("ScrollingFrame") and i.Name ~= "MenuScrolling" then 
                i.Visible = false 
            end
        end
        Child.Frame.Visible = true
    end)
    
    setmetatable(Child, ButtonTop)
    return Child.Frame
end

local function addToggle(Text, Callback)
    local Enabled = false
    local buttonToggle = textButton:Clone()
    buttonToggle.Size=UDim2.new(1, 0, 0, 32)
    buttonToggle.Text = Text .. " : OFF"
    buttonToggle.TextColor3 = THEME.ToggleOff
    
    buttonToggle.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        if Enabled then
            buttonToggle.Text = Text .. " : ON"
            buttonToggle.TextColor3 = THEME.ToggleOn
        else
            buttonToggle.Text = Text .. " : OFF"
            buttonToggle.TextColor3 = THEME.ToggleOff
        end
        if Callback then task.spawn(Callback, Enabled) end
    end)
    return buttonToggle
end

local function addClickButton(Text, Callback)
    local ClickBtn = textButton:Clone()
    ClickBtn.Size=UDim2.new(1, 0, 0, 32)
    ClickBtn.Text = Text
    ClickBtn.MouseButton1Click:Connect(function()
        if Callback then task.spawn(Callback) end
    end)
    return ClickBtn
end

local function addTextBox(Placeholder)
    local NewTextBox = textTextBox:Clone()
    NewTextBox.Size=UDim2.new(1, 0, 0, 32)
    NewTextBox.PlaceholderText = Placeholder
    NewTextBox.Text = ""
    
    NewTextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            NewTextBox.Text = enterPressed
        end
    end)
    return NewTextBox
end

local function SearchButton(listBase)
    local Output = {
        SelectedValue = listBase[1] or "",
        MainButton = nil,               
        DropdownList = nil
    }
    
    local Frameem = FrameTop:Clone()
    local textButtonFind = textButton:Clone()
    textButtonFind.Text = listBase[1] or "Select Option..."
    textButtonFind.Size = UDim2.new(1, 0, 1, 0)
    textButtonFind.Parent = Frameem
    Output.MainButton = textButtonFind
    
    local ScrollingList = Scrolling:Clone()
    ScrollingList.Parent = frame
    ScrollingList.Size = UDim2.new(0, 180, 0, 120)
    ScrollingList.ZIndex = 20
    ScrollingList.BackgroundColor3 = THEME.Background
    Output.DropdownList = ScrollingList
    
    local function updateDropdownPosition()
        local absPosFrame = frame.AbsolutePosition
        local absPosButton = textButtonFind.AbsolutePosition
        local offsetX = absPosButton.X - absPosFrame.X
        local offsetY = absPosButton.Y - absPosFrame.Y + textButtonFind.AbsoluteSize.Y + 4
        ScrollingList.Position = UDim2.new(0, offsetX, 0, offsetY)
    end
    
    for _, i in ipairs(listBase) do
        local ButtonInto = textButton:Clone()
        ButtonInto.Size=UDim2.new(1, 0, 0, 32)
        ButtonInto.Text = i
        ButtonInto.ZIndex = 21
        ButtonInto.Parent = ScrollingList
        ButtonInto.MouseButton1Click:Connect(function()
            textButtonFind.Text = ButtonInto.Text
            Output.SelectedValue = ButtonInto.Text
            ScrollingList.Visible = false
        end)
    end
    
    textButtonFind.MouseButton1Click:Connect(function()
        if not ScrollingList.Visible then
            updateDropdownPosition() 
        end
        ScrollingList.Visible = not ScrollingList.Visible
    end)
    
    return Frameem, Output
end

local function keotheochuot(Button, framemove)
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        framemove.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
    
    Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = framemove.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    Button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Events Bắt Đầu Kéo Trượt
Icon.MouseButton1Up:Connect(function()
    frame.Visible = not frame.Visible
end)

closeButton.MouseButton1Up:Connect(function()
    frame.Visible = false
end)

keotheochuot(Icon, frameIcon)
keotheochuot(Title, frame)

local humanoid = Character:WaitForChild("Humanoid")

local Main = ButtonTop.addButton("Main")
local Mis = ButtonTop.addButton("Mis")

local flyForce = nil
local AlignOrientation = nil 
local attachment = nil
local seat_var=nil
local HasStar=true
local SpeedCar_Var=30

local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local MasterControl = require(PlayerScripts:WaitForChild("PlayerModule")):GetControls()

local function flyCar(ed)
    if ed and seat_var then
        local carRoot=seat_var.Parent:FindFirstChild("MAIN")
        if not carRoot then showNotification("err","loi Main") return end
        flyForce = Instance.new("LinearVelocity")
        flyForce.Name="s"
        flyForce.MaxForce = 999999999999999
        flyForce.RelativeTo = Enum.ActuatorRelativeTo.World
        flyForce.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        AlignOrientation = Instance.new("AlignOrientation")
        AlignOrientation.MaxTorque = 100000000
        AlignOrientation.Responsiveness = 50
        attachment = Instance.new("Attachment")
        attachment.Parent = carRoot
        attachment.Name="s"
        flyForce.Attachment0 = attachment
        AlignOrientation.Attachment0 = attachment
        AlignOrientation.Parent = carRoot
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
        flyForce.Parent = carRoot
    else
        if flyForce then flyForce:Destroy() flyForce=nil end
        if attachment then attachment:Destroy() attachment=nil end
        if AlignOrientation then AlignOrientation:Destroy() AlignOrientation = nil end
    end
end

RunService.RenderStepped:Connect(function()
    if humanoid.Sit and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") and flyForce then
        local moveVector = MasterControl:GetMoveVector()
        if moveVector.Magnitude > 0 then
            local worldDirection = Camera.CFrame:VectorToWorldSpace(Vector3.new(moveVector.X, 0, moveVector.Z))
            flyForce.VectorVelocity = worldDirection * SpeedCar_Var
            else
            flyForce.VectorVelocity = Vector3.zero
        end
        local cameraLook = Camera.CFrame.LookVector
        local targetCFrame = CFrame.lookAt(
        Vector3.new(0, 0, 0), 
        Vector3.new(-1*cameraLook.X, 0, -1*cameraLook.Z)
        )
        AlignOrientation.CFrame = targetCFrame
    end
end)

humanoid.Seated:Connect(function(isSitting, seat)
    if isSitting and seat and seat:IsA("VehicleSeat") then
        seat_var=seat
    else
        seat_var=nil
        flyCar(false)
    end
end)

local box_speed=addTextBox("10")
box_speed.Parent=Main
local dash=addToggle("dash",function (ed)
    if ed then
        SpeedCar_Var=tonumber(box_speed.Text) or 30
        if not seat_var then showNotification("err","nhan vat chua ngoi") return end
        flyCar(true)
    else
        flyCar(false)
    end
end)
dash.Parent=Main

