local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Bảng màu Modern Dark Theme
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

-- Hàm hỗ trợ tạo UICorner nhanh
local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
    return corner
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

-- Khung Main Menu
local frame = Instance.new("Frame")
frame.Name = "frame"
frame.Size = UDim2.new(0, 520, 0, 340)
frame.Position = UDim2.new(0.15, 0, 0.15, 0)
frame.BackgroundColor3 = THEME.Background
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = MenuGUI
addCorner(frame, 10)

-- Thanh Tiêu Đề (Title Bar)
local Title = Instance.new("TextButton")
Title.Name = "Title"
Title.Text = "  nhỏ nhạc Hub  |  make by: Next :>"
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
MenuScrolling.Parent = frame
addCorner(MenuScrolling, 8)

local LeftListLayout = Instance.new("UIListLayout")
LeftListLayout.Padding = UDim.new(0, 4)
LeftListLayout.SortOrder = Enum.SortOrder.LayoutOrder
LeftListLayout.Parent = MenuScrolling

local LeftPadding = Instance.new("UIPadding")
LeftPadding.PaddingTop = UDim.new(0, 4)
LeftPadding.PaddingBottom = UDim.new(0, 4)
LeftPadding.PaddingLeft = UDim.new(0, 4)
LeftPadding.PaddingRight = UDim.new(0, 4)
LeftPadding.Parent = MenuScrolling

-- Template Nút Bấm
local textButton = Instance.new("TextButton")
textButton.Name = "Button"
textButton.Font = Enum.Font.GothamMedium
textButton.TextSize = 13
textButton.TextColor3 = THEME.Text
textButton.Size = UDim2.new(1, 0, 0, 32)
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
RightListLayout.Padding = UDim.new(0, 6)
RightListLayout.SortOrder = Enum.SortOrder.LayoutOrder
RightListLayout.Parent = Scrolling

local RightPadding = Instance.new("UIPadding")
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
textTextBox.Name = "TextBox"
textTextBox.Font = Enum.Font.Gotham
textTextBox.TextSize = 13
textTextBox.TextColor3 = THEME.Text
textTextBox.Size = UDim2.new(1, 0, 0, 32)
textTextBox.BackgroundColor3 = THEME.Button
textTextBox.BorderSizePixel = 0
textTextBox.PlaceholderColor3 = THEME.TextSub
textTextBox.ClearTextOnFocus = false
addCorner(textTextBox, 6)

-- Template Dropdown Frame
local frameTop = Instance.new("Frame")
frameTop.Name = "frameTop"
frameTop.Size = UDim2.new(1, 0, 0, 32)
frameTop.BackgroundColor3 = THEME.Button
frameTop.BorderSizePixel = 0
addCorner(frameTop, 6)

-- Notification UI
local FrameNotification = Instance.new("Frame")
FrameNotification.Name = "FrameNotification"
FrameNotification.Size = UDim2.new(0, 220, 0, 60)
FrameNotification.Position = UDim2.new(1, 10, 0, 20)
FrameNotification.BackgroundColor3 = THEME.Container
FrameNotification.BorderSizePixel = 0
FrameNotification.Visible = false
addCorner(FrameNotification, 8)

local TitleNotification = Instance.new("TextLabel")
TitleNotification.Name = "TitleNotification"
TitleNotification.Font = Enum.Font.GothamBold
TitleNotification.TextSize = 13
TitleNotification.TextColor3 = THEME.Accent
TitleNotification.Size = UDim2.new(1, -10, 0, 25)
TitleNotification.Position = UDim2.new(0, 10, 0, 0)
TitleNotification.BackgroundTransparency = 1
TitleNotification.TextXAlignment = Enum.TextXAlignment.Left
TitleNotification.Parent = FrameNotification

local MgsNotification = Instance.new("TextLabel")
MgsNotification.Name = "MgsNotification"
MgsNotification.Font = Enum.Font.Gotham
MgsNotification.TextSize = 12
MgsNotification.TextColor3 = THEME.Text
MgsNotification.Size = UDim2.new(1, -20, 0, 30)
MgsNotification.Position = UDim2.new(0, 10, 0, 25)
MgsNotification.BackgroundTransparency = 1
MgsNotification.TextXAlignment = Enum.TextXAlignment.Left
MgsNotification.TextWrapped = true
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
    ClickBtn.Text = Text
    ClickBtn.MouseButton1Click:Connect(function()
        if Callback then task.spawn(Callback) end
    end)
    return ClickBtn
end

local function addTextBox(Placeholder)
    local NewTextBox = textTextBox:Clone()
    NewTextBox.PlaceholderText = Placeholder
    NewTextBox.Text = ""
    
    NewTextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            -- Xử lý dữ liệu khi người dùng ấn Enter
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
    
    local Frameem = frameTop:Clone()
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

-- Logic Kéo Trượt Window (Drag GUI)
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

local Animate=ButtonTop.addButton("Animate")
local Mic=ButtonTop.addButton("Mic")

local Animate_Dictionary = {
  ["Astronaut"] = {
    ["Idle"]  = {"891621366", "891633237", "1047759695"},
    ["Walk"]  = "891636393",
    ["Run"]   = "891636393",
    ["Jump"]  = "891627522",
    ["Fall"]  = "891617961",
    ["Climb"] = "891609353"
  },
  ["Bubbly"] = {
    ["Idle"]  = {"910004836", "910009958", "1018536639"},
    ["Walk"]  = "910034870",
    ["Run"]   = "910025107",
    ["Jump"]  = "910016857",
    ["Fall"]  = "910001910",
    ["Climb"] = "909997997"
  },
  ["Cartoony"] = {
    ["Idle"]  = {"742637544", "742638445", "885477856"},
    ["Walk"]  = "742640026",
    ["Run"]   = "742638842",
    ["Jump"]  = "742637942",
    ["Fall"]  = "742637151",
    ["Climb"] = "742636889"
  },
  ["Elder"] = {
    ["Idle"]  = {"845397899", "845400520", "901160519"},
    ["Walk"]  = "845403856",
    ["Run"]   = "845386501",
    ["Jump"]  = "845398858",
    ["Fall"]  = "845396048",
    ["Climb"] = "845392038"
  },
  ["Knight"] = {
    ["Idle"]  = {"657595757", "657568135", "885499184"},
    ["Walk"]  = "657552124",
    ["Run"]   = "657564596",
    ["Jump"]  = "658409194",
    ["Fall"]  = "657560338",
    ["Climb"] = "65830781"
  },
  ["Levitation"] = {
    ["Idle"]  = {"616006778", "616008087", "886862142"},
    ["Walk"]  = "616013216",
    ["Run"]   = "616010382",
    ["Jump"]  = "616008936",
    ["Fall"]  = "616005863",
    ["Climb"] = "616003713"
  },
  ["Mage"] = {
    ["Idle"]  = {"707742142", "707855907", "885508740"},
    ["Walk"]  = "707897309",
    ["Run"]   = "707861613",
    ["Jump"]  = "707853694",
    ["Fall"]  = "707829716",
    ["Climb"] = "707826056"
  },
  ["Ninja"] = {
    ["Run"]   = "656118852",
    ["Walk"]  = "656121766",
    ["Jump"]  = "656117878",
    ["Idle"]  = {"656117400", "656118341", "886742569"},
    ["Fall"]  = "656115606",
    ["Climb"] = "656114359"
  },
  ["Pirate"] = {
    ["Run"]   = "750783738",
    ["Walk"]  = "750785693",
    ["Jump"]  = "750782230",
    ["Idle"]  = {"750781874", "750782770", "885515365"},
    ["Fall"]  = "750780242",
    ["Climb"] = "750779899"
  },
  ["Robot"] = {
    ["Run"]   = "616091570",
    ["Walk"]  = "616095330",
    ["Jump"]  = "616090535",
    ["Idle"]  = {"616088211", "616089559", "885531463"},
    ["Fall"]  = "616087089",
    ["Climb"] = "616086039"
  },
  ["Rthro"] = {
    ["Run"]   = "2510198475",
    ["Walk"]  = "2510202577",
    ["Jump"]  = "2510197830",
    ["Idle"]  = {"2510197257", "2510196951", "3711062489"},
    ["Fall"]  = "2510195892",
    ["Climb"] = "2510192778"
  },
  ["Stylish"] = {
    ["Run"]   = "616140816",
    ["Walk"]  = "616146177",
    ["Jump"]  = "616139451",
    ["Idle"]  = {"616136790", "616138447", "886888594"},
    ["Fall"]  = "616134815",
    ["Climb"] = "616133594"
  },
  ["Superhero"] = {
    ["Run"]   = "616117076",
    ["Walk"]  = "616122287",
    ["Jump"]  = "616115533",
    ["Idle"]  = {"616111295", "616113536", "885535855"},
    ["Fall"]  = "616108001",
    ["Climb"] = "616104706"
  },
  ["Toy"] = {
    ["Run"]   = "782842708",
    ["Walk"]  = "782843345",
    ["Jump"]  = "782847020",
    ["Idle"]  = {"782841498", "782845736", "980952228"},
    ["Fall"]  = "782846423",
    ["Climb"] = "782843869"
  },
  ["Vampire"] = {
    ["Run"]   = "1083462077",
    ["Walk"]  = "1083473930",
    ["Jump"]  = "1083455352",
    ["Idle"]  = {"1083445855", "1083450166", "1088037547"},
    ["Fall"]  = "1083443587",
    ["Climb"] = "1083439238"
  },
  ["Werewolf"] = {
    ["Run"]   = "1083216690",
    ["Walk"]  = "1083217839",
    ["Jump"]  = "1083218792",
    ["Idle"]  = {"1083195517", "1083214717", "1099492820"},
    ["Fall"]  = "1083189019",
    ["Climb"] = "1083182000"
  },
  ["Zombie"] = {
    ["Run"]   = "616163682",
    ["Walk"]  = "616168032",
    ["Jump"]  = "616161997",
    ["Idle"]  = {"616158929", "616160636", "885545458"},
    ["Fall"]  = "616157476",
    ["Climb"] = "616156119"
  }
}
local Save_A=Animate_Dictionary["Toy"]

local pack_List={}
for i,_ in pairs(Animate_Dictionary) do
  table.insert(pack_List,i)
end

local function save_Animate(Var,Id,Anime)
  local Anim = Var:FindFirstChild(Anime)
  if Anim then
    Anim.AnimationId = "rbxassetid://"..Id
  else
    local newAnim = Instance.new("Animation")
    newAnim.Name = Anime
    newAnim.AnimationId = "rbxassetid://"..Id
    newAnim.Parent = Var
  end
end

local function overrideRunAnimation(character,Name,Id)
  local animator = character:WaitForChild("Humanoid", 5):WaitForChild("Animator", 5)
  local animateScript = character:WaitForChild("Animate", 5)
  
  if not animateScript or not animator then
    showNotification("err","loi lay du lieu",5)
    return 
  end
  
  local Value = animateScript:FindFirstChild(Name:lower())
  if Value then
    if Name=="Idle" then
      save_Animate(Value,Id[1],"Animation1")
      save_Animate(Value,Id[2],"Animation2")
    else
      save_Animate(Value,Id,Name.."Anim")
    end
  end
  
  -- 2. Dừng tất cả các hoạt ảnh chạy cũ đang bị kẹt trong bộ nhớ đệm (Cache) của Animator
  for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
    if track.Name:lower():find(Name:lower()) then
      track:Stop()
    end
  end
end

Anima=SearchButton(pack_List)
Anima.Parent=Animate
Anima.LayoutOrder=2
Tye=SearchButton({"all","Idle","Walk","Run","Jump","Fall","Climb"})
Tye.Parent=Animate
Tye.LayoutOrder=1
but1=addClickButton("set",function()
  if Tye.SelectedValue=="" then
    return
  end
  if Tye.SelectedValue=="all" then
    Save_A=Animate_Dictionary[Anima.SelectedValue]
    for i,j in pairs(Animate_Dictionary[Anima.SelectedValue]) do
      overrideRunAnimation(Character,i,j)
    end
  else
    Save_A[Tye.SelectedValue]=Animate_Dictionary[Anima.SelectedValue][Tye.SelectedValue]
    overrideRunAnimation(Character,Tye.SelectedValue,Save_A[Tye.SelectedValue])
  end
end)
but1.Parent=Animate
but1.LayoutOrder=3

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
  task.wait(0.5)
  Character = newCharacter
  Humanoid = newCharacter:WaitForChild("Humanoid")
  for i,j in pairs(Save_A) do
    overrideRunAnimation(Character,i,j)
  end
end)
