# Namespace

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**CreationDate** | **time.Time** | Date and time when the namespace was created. | 
**LastUpdated** | **time.Time** | Date and time when the namespace was last updated. | 
**Name** | **string** | Name of the namespace. | 
**Persistent** | **bool** | Indicates if the namespace is persistent. | 
**Personal** | **bool** | Indicates if the namespace is the default namespace for any user in the instance. | 
**Status** | **string** | Status of the namespace. Possible values are &#39;Active&#39;, &#39;Inactive&#39;, &#39;Deleted&#39;. | 
**Type** | **string** | Type of the namespace. Possible values are &#39;Development&#39; and &#39;Preview&#39;. | 
**Uuid** | **string** | Unique identifier of the namespace. | 

## Methods

### NewNamespace

`func NewNamespace(creationDate time.Time, lastUpdated time.Time, name string, persistent bool, personal bool, status string, type_ string, uuid string, ) *Namespace`

NewNamespace instantiates a new Namespace object
This constructor will assign default values to properties that have it defined,
and makes sure properties required by API are set, but the set of arguments
will change when the set of required properties is changed

### NewNamespaceWithDefaults

`func NewNamespaceWithDefaults() *Namespace`

NewNamespaceWithDefaults instantiates a new Namespace object
This constructor will only assign default values to properties that have it defined,
but it doesn't guarantee that properties required by API are set

### GetCreationDate

`func (o *Namespace) GetCreationDate() time.Time`

GetCreationDate returns the CreationDate field if non-nil, zero value otherwise.

### GetCreationDateOk

`func (o *Namespace) GetCreationDateOk() (*time.Time, bool)`

GetCreationDateOk returns a tuple with the CreationDate field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetCreationDate

`func (o *Namespace) SetCreationDate(v time.Time)`

SetCreationDate sets CreationDate field to given value.


### GetLastUpdated

`func (o *Namespace) GetLastUpdated() time.Time`

GetLastUpdated returns the LastUpdated field if non-nil, zero value otherwise.

### GetLastUpdatedOk

`func (o *Namespace) GetLastUpdatedOk() (*time.Time, bool)`

GetLastUpdatedOk returns a tuple with the LastUpdated field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetLastUpdated

`func (o *Namespace) SetLastUpdated(v time.Time)`

SetLastUpdated sets LastUpdated field to given value.


### GetName

`func (o *Namespace) GetName() string`

GetName returns the Name field if non-nil, zero value otherwise.

### GetNameOk

`func (o *Namespace) GetNameOk() (*string, bool)`

GetNameOk returns a tuple with the Name field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetName

`func (o *Namespace) SetName(v string)`

SetName sets Name field to given value.


### GetPersistent

`func (o *Namespace) GetPersistent() bool`

GetPersistent returns the Persistent field if non-nil, zero value otherwise.

### GetPersistentOk

`func (o *Namespace) GetPersistentOk() (*bool, bool)`

GetPersistentOk returns a tuple with the Persistent field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetPersistent

`func (o *Namespace) SetPersistent(v bool)`

SetPersistent sets Persistent field to given value.


### GetPersonal

`func (o *Namespace) GetPersonal() bool`

GetPersonal returns the Personal field if non-nil, zero value otherwise.

### GetPersonalOk

`func (o *Namespace) GetPersonalOk() (*bool, bool)`

GetPersonalOk returns a tuple with the Personal field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetPersonal

`func (o *Namespace) SetPersonal(v bool)`

SetPersonal sets Personal field to given value.


### GetStatus

`func (o *Namespace) GetStatus() string`

GetStatus returns the Status field if non-nil, zero value otherwise.

### GetStatusOk

`func (o *Namespace) GetStatusOk() (*string, bool)`

GetStatusOk returns a tuple with the Status field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetStatus

`func (o *Namespace) SetStatus(v string)`

SetStatus sets Status field to given value.


### GetType

`func (o *Namespace) GetType() string`

GetType returns the Type field if non-nil, zero value otherwise.

### GetTypeOk

`func (o *Namespace) GetTypeOk() (*string, bool)`

GetTypeOk returns a tuple with the Type field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetType

`func (o *Namespace) SetType(v string)`

SetType sets Type field to given value.


### GetUuid

`func (o *Namespace) GetUuid() string`

GetUuid returns the Uuid field if non-nil, zero value otherwise.

### GetUuidOk

`func (o *Namespace) GetUuidOk() (*string, bool)`

GetUuidOk returns a tuple with the Uuid field if it's non-nil, zero value otherwise
and a boolean to check if the value has been set.

### SetUuid

`func (o *Namespace) SetUuid(v string)`

SetUuid sets Uuid field to given value.



[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


