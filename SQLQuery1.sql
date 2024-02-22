Select * from SQL_Practice.dbo.housing


-- Date Conversion

ALTER TABLE housing
Add	SaleDateConverted Date;

Update housing
SET SaleDateConverted = CONVERT(Date,SaleDate)

Select SaleDateConverted From housing



-- Property Address

Select PropertyAddress
From housing
Where PropertyAddress is null


Select * from housing
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From housing a
Join housing b
on a.ParcelID = b.ParcelID
and a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null


Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From housing a
Join housing b
on a.ParcelID = b.ParcelID
and a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null



Select PropertyAddress
From housing

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
From housing

Alter table housing
Add PropertySplitAddress Nvarchar(255)

Update housing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

Alter table housing
Add PropertySplitCity Nvarchar(255)

Update housing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

select * from housing


-- Another way

Select
PARSENAME(REPLACE(OwnerAddress, ',','.'),3),
PARSENAME(Replace(OwnerAddress, ',','.'),2),
PARSENAME(Replace(OwnerAddress, ',','.'),1)
from housing

Alter table housing
Add OwnerSplitAddress Nvarchar(255)

Update housing
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'),3)

Alter table housing
Add OwnerSplitCity Nvarchar(255)

Update housing
Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',','.'),2)

Alter table housing
Add OwnerSplitState Nvarchar(255)

Update housing
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',','.'),1)

Select * from housing


-- Changing values in Sold as Vacant Column from Y to Yes and N to No

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From housing
Group by SoldAsVacant

Select SoldAsVacant,
Case when SoldAsVacant = 'Y' Then 'Yes'
	 when SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End
From housing


Update housing
Set SoldAsVacant = Case when SoldAsVacant = 'Y' Then 'Yes'
	 when SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End


-- Delete Unused Columns

Select * from housing

Alter Table housing
Drop column SaleDate

Alter Table housing
Drop column PropertyAddress, OwnerAddress
