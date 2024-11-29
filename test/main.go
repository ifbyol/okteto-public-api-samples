package main

import (
	"context"
	"fmt"
	"os"

	"github.com/ifbyol/okteto-public-api-samples/test/okteto"
)

func main() {
	token := os.Getenv("OKTETO_TOKEN")
	host := os.Getenv("OKTETO_HOST")
	config := okteto.NewConfiguration()
	config.Host = host
	config.DefaultHeader["Authorization"] = fmt.Sprintf("Bearer %s", token)
	client := okteto.NewAPIClient(config)

	ctx := context.Background()
	r, stats, err := client.NamespacesAPI.ListNamespaces(ctx).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "There was an error requesting the namespaces %s\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", stats)
		return
	}

	for _, namespace := range r {
		fmt.Printf("Namespace %q\n", namespace.Name)
	}
}
