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
corner.Name = "UICorner"
local function addCorner(parent, radius)
    if not parent then return end
    local var = parent:FindFirstChild("UICorner")
    if var then var:Destroy() end
    local corner1 = corner:Clone()
    corner1.CornerRadius = UDim.new(0, radius or 6)
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

local textButtonTop = Instance.new("TextButton")
textButtonTop.Name="textButton"
textButtonTop.Font = Enum.Font.GothamBold
textButtonTop.TextColor3 = THEME.Text
textButtonTop.BackgroundColor3 = THEME.Button
textButtonTop.BorderSizePixel = 0
addCorner(textButtonTop, 6)

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

local function addToggle(Text,parent, Callback)
    local Enabled = false
    local buttonToggle = textButton:Clone()
    buttonToggle.Size=UDim2.new(1, 0, 0, 32)
    buttonToggle.Text = Text .. " : OFF"
    buttonToggle.TextColor3 = THEME.ToggleOff
    buttonToggle.Parent=parent
    
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

local function addClickButton(Text,parent, Callback)
    local ClickBtn = textButton:Clone()
    ClickBtn.Size=UDim2.new(1, 0, 0, 32)
    ClickBtn.Text = Text
    ClickBtn.Parent=parent
    ClickBtn.MouseButton1Click:Connect(function()
        if Callback then task.spawn(Callback) end
    end)
    return ClickBtn
end

local function addTextBox(Placeholder,parent)
    local NewTextBox = textTextBox:Clone()
    NewTextBox.Size=UDim2.new(1, 0, 0, 32)
    NewTextBox.PlaceholderText = Placeholder
    NewTextBox.Text = ""
    NewTextBox.Parent=parent
    
    NewTextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            NewTextBox.Text = enterPressed
        end
    end)
    return NewTextBox
end

local function sliderButton(dau,cuoi,parent)
    local Output = {
        Dragging=false,
        Value=dau,
        Frame = {
            FrameC=nil,
            FrameC1=nil,
            Button=nil,
            Label=nil,
            LabelC=nil
        }
    }
    Output.Frame.FrameC=FrameTop:Clone()
    Output.Frame.FrameC.Size=UDim2.new(1, 0, 0, 32)
    Output.Frame.FrameC.Parent=parent
    Output.Frame.Label=TextLabelTop:Clone()
    Output.Frame.Label.Size=UDim2.new(0.2, 0, 1, 0)
    Output.Frame.Label.Text=Output.Value
    Output.Frame.Label.Parent=Output.Frame.FrameC
    Output.Frame.FrameC1=FrameTop:Clone()
    Output.Frame.FrameC1.Size=UDim2.new(0.8, 0, 1, 0)
    Output.Frame.FrameC1.Position=UDim2.new(0.2, 0, 0, 0)
    Output.Frame.FrameC1.Parent=Output.Frame.FrameC
    Output.Frame.LabelC=TextLabelTop:Clone()
    Output.Frame.LabelC.Size=UDim2.new(0.8, 0, 0, 10)
    Output.Frame.LabelC.AnchorPoint=Vector2.new(0.5,0.5)
    Output.Frame.LabelC.Position=UDim2.new(0.5, 0, 0.5, 0)
    Output.Frame.LabelC.Parent=Output.Frame.FrameC1
    Output.Frame.Button=textButtonTop:Clone()
    Output.Frame.Button.Position=UDim2.new(0, 0, 0.5, 0)
    Output.Frame.Button.Size=UDim2.new(0, 15, 0, 15)
    Output.Frame.Button.AnchorPoint=Vector2.new(0.5,0.5)
    Output.Frame.Button.Parent=Output.Frame.LabelC
    
    function Output.Update(input)
        local backgroundAbsPos = Output.Frame.LabelC.AbsolutePosition.X
        local backgroundAbsSize = Output.Frame.LabelC.AbsoluteSize.X
        local delta=math.clamp((input.Position.X-backgroundAbsPos)/backgroundAbsSize,0,1)
        Output.Frame.Button.Position=UDim2.new(delta, 0, 0.5, 0)
        Output.Value=dau+delta*(cuoi-dau)
        Output.Frame.Label.Text=tostring(math.floor(Output.Value))
    end
        
    Output.Frame.Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Output.Dragging = true
        end
    end)
    return Output
end

local function SearchButton(listBase,parent)
    local Output = {
        SelectedValue = listBase[1] or "",
        MainButton = nil,               
        DropdownList = nil
    }
    
    local Frameem = FrameTop:Clone()
    Frameem.Parent=parent
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
    local Dragging = false
    local dragInput=nil
    local dragStart=nil
    local startPos=nil
    
    
    Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            dragStart = input.Position
            startPos = framemove.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    Button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            framemove.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    return Output
end

Icon.MouseButton1Up:Connect(function()
    frame.Visible = not frame.Visible
end)

closeButton.MouseButton1Up:Connect(function()
    frame.Visible = false
end)

local MainT={
    InputList={}
}

keotheochuot(Icon, frameIcon)
keotheochuot(Title, frame)

local Main = ButtonTop.addButton("Main")
local Mis = ButtonTop.addButton("Mis")

local speed=sliderButton(16,300,Main)
table.insert(MainT.InputList,speed)
local apl=addToggle("set speed",Main,function (ed)
    if ed then 
        if Character then
            local humanoid = Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed.Value
            else
                showNotification("err","loi humanoid")
            end
        else
            showNotification("err","loi char")
        end
        LockButtonEnabled(speed.Frame.Button,not ed)
    else
        LockButtonEnabled(speed.Frame.Button,not ed)
    end
end)

local jumpinf=addToggle("infjump",Main,function(ed)
    local jumpConnection = nil
    if ed then 
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end
end)

local humanoid = Character:WaitForChild("Humanoid")
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    local humanoid = newCharacter:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.WalkSpeed = speed.Value
    end
end)
UserInputService.InputEnded:Connect(function(input)
    for _,i in ipairs(MainT.InputList) do
        if i.Dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            i.Dragging = false
        end
    end
end)
UserInputService.InputChanged:Connect(function(input)
    for _,i in ipairs(MainT.InputList) do
        if i.Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            i.Update(input)
        end
    end
end)
