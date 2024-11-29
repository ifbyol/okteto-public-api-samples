# \NamespacesAPI

All URIs are relative to *https://okteto.test.com/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ListNamespaces**](NamespacesAPI.md#ListNamespaces) | **Get** /namespaces | Get list of namespaces managed by the Okteto platform



## ListNamespaces

> []Namespace ListNamespaces(ctx).Type_(type_).Execute()

Get list of namespaces managed by the Okteto platform



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/ifbyol/okteto-public-api-samples"
)

func main() {
	type_ := "type__example" // string | Type of the namespace to filter. Possible values are 'Development' and 'Preview'. (optional)

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.NamespacesAPI.ListNamespaces(context.Background()).Type_(type_).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `NamespacesAPI.ListNamespaces``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `ListNamespaces`: []Namespace
	fmt.Fprintf(os.Stdout, "Response from `NamespacesAPI.ListNamespaces`: %v\n", resp)
}
```

### Path Parameters



### Other Parameters

Other parameters are passed through a pointer to a apiListNamespacesRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type_** | **string** | Type of the namespace to filter. Possible values are &#39;Development&#39; and &#39;Preview&#39;. | 

### Return type

[**[]Namespace**](Namespace.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)

