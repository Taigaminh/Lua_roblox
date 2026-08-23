local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Tạo GUI 
local MenuGUI = Instance.new("ScreenGui")
MenuGUI.Name = "MenuGUI"
MenuGUI.DisplayOrder = 0
MenuGUI.IgnoreGuiInset = true
MenuGUI.ResetOnSpawn = false
MenuGUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frameIcon = Instance.new("Frame")
frameIcon.Name="frameIcon"
frameIcon.Size=UDim2.new(0, 20, 0, 20)
frameIcon.Position=UDim2.new(0.08, 0, 0.2, 0)
frameIcon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frameIcon.BorderSizePixel = 1
frameIcon.BorderColor3 = Color3.fromRGB(0, 255, 255)
frameIcon.Parent=MenuGUI

local Icon = Instance.new("ImageButton")
Icon.Name = "Icon"
Icon.Size = UDim2.new(1, 0, 1, 0)
Icon.Position = UDim2.new(0, 0, 0, 0)
Icon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Icon.BorderSizePixel = 1
Icon.BorderColor3 = Color3.fromRGB(0, 255, 255)
Icon.Parent = frameIcon

local frame = Instance.new("Frame")
frame.Name="frame"
frame.Size=UDim2.new(0.75, 0, 0.75, 0)
frame.Position=UDim2.new(0.18, 0, 0.15, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 1
frame.BorderColor3 = Color3.fromRGB(0, 255, 255)
frame.Parent=MenuGUI

local Title = Instance.new("TextButton")
Title.Name = "Title"
Title.Text = "nho nhac Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Size = UDim2.new(1, 0, 0.05, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 1
Title.BorderColor3 = Color3.fromRGB(0, 255, 255)
Title.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Name = "closeButton"
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Size = UDim2.new(0.05, 0, 1, 0)
closeButton.Position = UDim2.new(0.95, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
closeButton.BorderSizePixel = 1
closeButton.BorderColor3 = Color3.fromRGB(0, 255, 255)
closeButton.Parent = Title

local MenuScrolling = Instance.new("ScrollingFrame")
MenuScrolling.Name = "MenuScrolling"
MenuScrolling.Size = UDim2.new(0.2, 0, 0.95, 0)
MenuScrolling.Position = UDim2.new(0, 0, 0.05, 0)
MenuScrolling.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MenuScrolling.BorderColor3 = Color3.fromRGB(0, 255, 255)
MenuScrolling.BorderSizePixel = 1
MenuScrolling.ScrollBarThickness = 0
MenuScrolling.Parent = frame

-- 🌟 Thêm UIListLayout vào Menu Thang Cuộn Trái để tự động xếp nút bấm
local LeftListLayout = Instance.new("UIListLayout")
LeftListLayout.Padding = UDim.new(0, 2) -- Khoảng cách giữa các nút là 2 pixel
LeftListLayout.Parent = MenuScrolling

local textButton = Instance.new("TextButton")
textButton.Name = "Button"
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.Size = UDim2.new(1, 0, 0, 35)
textButton.Position = UDim2.new(0, 0, 0, 0)
textButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textButton.BorderSizePixel = 1
textButton.BorderColor3 = Color3.fromRGB(0, 255, 255)

local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Name = "Scrolling"
Scrolling.Size = UDim2.new(0.8, 0, 0.95, 0)
Scrolling.Position = UDim2.new(0.2, 0, 0.05, 0)
Scrolling.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Scrolling.BorderSizePixel = 1
Scrolling.BorderColor3 = Color3.fromRGB(0, 255, 255)
Scrolling.ScrollBarThickness = 0
Scrolling.Visible = false
Scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)

-- 🌟 Thêm UIListLayout vào Khung Nội Dung Mẫu để sau này các tính năng bên trong tự xếp hàng thẳng thớm
local RightListLayout = Instance.new("UIListLayout")
RightListLayout.Padding = UDim.new(0, 5)
RightListLayout.Parent = Scrolling
RightListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end)


local textTextBox = Instance.new("TextBox")
textTextBox.Name = "TextBox"
textTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textTextBox.Size = UDim2.new(1, 0, 0, 35)
textTextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textTextBox.BorderSizePixel = 1
textTextBox.BorderColor3 = Color3.fromRGB(0, 255, 255)
textTextBox.Font = Enum.Font.SourceSans
textTextBox.TextSize = 14
textTextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)

local frameTop = Instance.new("Frame")
frameTop.Name="frameTop"
frameTop.Size=UDim2.new(1, 0, 0, 35)
frameTop.Position=UDim2.new(0, 0, 0, 0)
frameTop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frameTop.BorderSizePixel = 1
frameTop.BorderColor3 = Color3.fromRGB(0, 255, 255)

local textLabelTop = Instance.new("TextLabel")
textLabelTop.Name="textLabelTop"
textLabelTop.Size=UDim2.new(0, 0, 0, 0)
textLabelTop.Position=UDim2.new(0, 0, 0, 0)
textLabelTop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textLabelTop.BorderSizePixel = 1
textLabelTop.BorderColor3 = Color3.fromRGB(0, 255, 255)

--Notification
local FrameNotification = Instance.new("Frame")
FrameNotification.Name="FrameNotification"
FrameNotification.Size=UDim2.new(0.2, 0, 0.1, 0)
FrameNotification.Position=UDim2.new(1, 0, 0, 0)
FrameNotification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FrameNotification.Visible = false

local TitleNotification = Instance.new("TextLabel")
TitleNotification.Name="TitleNotification"
TitleNotification.Size=UDim2.new(1,0,0.4,0)
TitleNotification.Position=UDim2.new(0,0,0,0)
TitleNotification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TitleNotification.Parent = FrameNotification

local MgsNotification = Instance.new("TextLabel")
MgsNotification.Name="MgsNotification"
MgsNotification.Size=UDim2.new(1,0,0.6,0)
MgsNotification.Position=UDim2.new(0,0,0.4,0)
MgsNotification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MgsNotification.Parent=FrameNotification

--MgsNotification
local tweenInfo = TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
local function showNotification(title, message, duration)
  local Var=FrameNotification:Clone()
  Var.Parent = MenuGUI
  Var.TitleNotification.Text=title
  Var.MgsNotification.Text=message
  Var.Visible=true
  local tweenIn = TweenService:Create(Var, tweenInfo, {Position = UDim2.new(0.8,0,0,0)})
  tweenIn:Play()
  tweenIn.Completed:Wait()
  task.wait(duration)
  local tweenOut = TweenService:Create(Var, tweenInfo, {Position = UDim2.new(1, 0, 0, 0)})
  tweenOut:Play()
  tweenOut.Completed:Wait()
  Var:Destroy()
end


--thiet keu nut bam
local ButtonTop={}
ButtonTop.__index = ButtonTop
function ButtonTop.addButton(Name)
  local Child={}
  Child.button=textButton:Clone()
  Child.button.Text=Name
  Child.button.Parent=MenuScrolling
  Child.Frame=Scrolling:Clone()
  Child.Frame.Parent=frame
  Child.button.MouseButton1Click:Connect(function()
    for _,i in ipairs(frame:GetChildren()) do
      if i:IsA("ScrollingFrame") and i.Name~="MenuScrolling" then i.Visible=false end
    end
    Child.Frame.Visible=true
  end)
  setmetatable(Child, ButtonTop)
  return Child
end

function ButtonTop:addToggle(Text, Callback)
  local Toggle = {}
  local Enabled = false
  Toggle.buttonToggle = textButton:Clone()
  Toggle.buttonToggle.Text=Text..":OFF"
  Toggle.buttonToggle.Parent=self.Frame
  Toggle.buttonToggle.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    if Enabled then
      Toggle.buttonToggle.Text=Text..":ON"
    else
      Toggle.buttonToggle.Text=Text..":OFF"
    end
    if Callback then task.spawn(Callback,Enabled) end
  end)
end

function ButtonTop:addClickButton(Text, Callback)
  self.Output=""
  local ClickBtn = textButton:Clone()
  ClickBtn.Text = Text
  ClickBtn.Parent = self.Frame
  ClickBtn.MouseButton1Click:Connect(function()
    if Callback then task.spawn(Callback) end
  end)
end

function ButtonTop:addTextBox(Text, Placeholder, Callback)
  local NewTextBox = textTextBox:Clone()
  NewTextBox.PlaceholderText = Placeholder
  NewTextBox.Text = ""
  NewTextBox.Parent = self.Frame
  -- Khi người chơi nhập xong và nhấn Enter
  NewTextBox.FocusLost:Connect(function(enterPressed)
    if Callback then 
      task.spawn(Callback, NewTextBox.Text, enterPressed) 
    end
  end)
end

function ButtonTop:SearchButton(listBase)
  local Output={
    SelectedValue = listBase[1] or "",
    MainButton = nil,               
    DropdownList = nil
  }
  local Frameem = frameTop:Clone()
  Frameem.Parent = self.Frame
  local textButtonFind = textButton:Clone()
  textButtonFind.Text="....."
  textButtonFind.Size = UDim2.new(1, 0, 1, 0)
  textButtonFind.Parent = Frameem
  Output.MainButton=textButtonFind
  local ScrollingList = Scrolling:Clone()
  ScrollingList.Parent = frame
  ScrollingList.Size=UDim2.new(0.4, 0, 0.4, 0)
  ScrollingList.ZIndex = 20
  Output.DropdownList = ScrollingList
  local function updateDropdownPosition()
    -- Tính toán vị trí thực tế của ô bấm đối với khung frame lớn
    local absPosFrame = frame.AbsolutePosition
    local absPosButton = textButtonFind.AbsolutePosition
    local offsetX = absPosButton.X - absPosFrame.X
    local offsetY = absPosButton.Y - absPosFrame.Y + textButtonFind.AbsoluteSize.Y
    ScrollingList.Position = UDim2.new(0, offsetX, 0, offsetY)
  end
  for _,i in ipairs(listBase) do
    local ButtonInto = textButton:Clone()
    ButtonInto.Text = i
    ButtonInto.ZIndex = 20
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
  return Output
end

local function keotheochuot(Button,framemove)
  local dragging = false
  local dragInput
  local dragStart
  local startPos
    
  local function update(input)
    local delta = input.Position - dragStart
    framemove.Position = UDim2.new(
    startPos.X.Scale,
    startPos.X.Offset + delta.X,
    startPos.Y.Scale,
    startPos.Y.Offset + delta.Y)
  end
  
  Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging = true
      dragStart = input.Position
      startPos = framemove.Position
      local connection
      connection=input.Changed:Connect(function()
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

Icon.MouseButton1Up:Connect(function()
  frame.Visible = not frame.Visible
end)

closeButton.MouseButton1Up:Connect(function()
  frame.Visible = false
end)

--set up menu
keotheochuot(Icon,frameIcon)
keotheochuot(Title,frame)

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

Anima=Animate:SearchButton(pack_List)
Tye=Animate:SearchButton({"all","Idle","Walk","Run","Jump","Fall","Climb"})
Animate:addClickButton("set",function()
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

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
  task.wait(0.5)
  Character = newCharacter
  Humanoid = newCharacter:WaitForChild("Humanoid")
  for i,j in pairs(Save_A) do
    overrideRunAnimation(Character,i,j)
  end
end)
